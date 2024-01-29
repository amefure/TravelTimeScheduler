//
//  ConvertTypeUtility.swift
//  TravelTimeScheduler
//
//  Created by t&a on 2023/05/21.
//

import UIKit
import RealmSwift

/// DBに格納時にデータのタイプをキャストする機能を提供するUtility
class ConvertTypeUtility {

    // MARK: - Travel(Realm)をFirebase上に新規登録する際の型変換
    // - 使用箇所：SwitchingDatabaseViewModel.swift
    
    /// Array<Schedule>  → Dictionary<String:String>
    public func convertScheduleToDictionary(schedules:RealmSwift.List<Schedule>) -> [String:[String:String]] {
        var joinSchedule:[String:[String:String]] = [:]
        
        for schedule in schedules {
            
            var endDateTime: String = ""
            if let time = schedule.endDateTime {
                endDateTime = DateFormatManager().getAllDateDisplayFormatString(time)
            }
            
            let array = [
                "content": schedule.content,
                "memo": schedule.memo,
                "dateTime": DateFormatManager().getAllDateDisplayFormatString(schedule.dateTime),
                "endDateTime": endDateTime,
                "type":schedule.type.rawValue,
                "tranceportation":schedule.tranceportation?.rawValue ?? Tranceportation.other.rawValue
            ]
            joinSchedule.updateValue(array, forKey: schedule.id.stringValue)
        }
        return joinSchedule
    }
    
    
    // MARK: - TravelをFirebase上から取得する際の型変換
    // - 使用箇所：SwitchingDatabaseViewModel.swift
    
    /// Array<String> → RealmSwift.List<String>
    public func convertMembersToList(_ members:[String]) -> RealmSwift.List<String>{
        let membersList:RealmSwift.List<String> = RealmSwift.List()
        membersList.append(objectsIn: members)
        return membersList
    }
    

    // MARK: - Travel(Realm)を更新する際のID変換
    // - 使用箇所：SwitchingDatabaseViewModel.swift
    
    /// String → ObjectId
    public func convertStringToObjectId(strID:String) -> RealmSwift.ObjectId {
        
        guard let obj = try? ObjectId(string: strID) else {
            return ObjectId.generate()
        }
        
        return obj
    }
    
    public func generateObjectIdString() -> String {
        return ObjectId.generate().stringValue
    }
}
