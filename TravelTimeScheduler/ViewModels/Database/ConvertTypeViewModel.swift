//
//  ConvertTypeViewModel.swift
//  TravelTimeScheduler
//
//  Created by t&a on 2023/05/21.
//

import UIKit
import RealmSwift


/// DBに格納時にデータのタイプをキャストする機能を提供するViewModels
class ConvertTypeViewModel {

    // MARK: - Travel(Realm)をFirebase上に新規登録する際の型変換
    // - Members   → カンマ(,)区切りの結合文字列にする
    // - Schedules → 辞書形式
    // - 使用箇所：SwitchingDatabaseViewModel.swift > func entryTravel
    
    /// Members ["User","User2"] → "User,User2" convert
    public func convertMembersToJoinString(members:RealmSwift.List<String>) -> String{
        var joinMember = ""
        for member in members{
            if joinMember.isEmpty {
                joinMember = member
            }else{
                joinMember += "," + member
            }
        }
        return joinMember
    }
    
    /// Schedules [Schedule,Schedule] → [id:,[key:value]]  convert
    public func convertScheduleToDictionary(schedules:RealmSwift.List<Schedule>) -> [String:[String:String]] {
        var joinSchedule:[String:[String:String]] = [:]
        for schedule in schedules {
            let array = [
                "content": schedule.content,
                "memo": schedule.memo,
                "dateTime":DisplayDateViewModel().getAllDateDisplayFormatString(schedule.dateTime),
                "type":schedule.type.rawValue,
                "tranceportation":schedule.tranceportation?.rawValue ?? Tranceportation.other.rawValue
            ]
            joinSchedule.updateValue(array, forKey: schedule.id.stringValue)
        }
        return joinSchedule
    }
    
    
    // MARK: - TravelをFirebase上から取得する際の型変換
    // - Members   → カンマ(,)区切りの結合文字列にする
    // - Schedules → 辞書形式
    // - 使用箇所：SwitchingDatabaseViewModel.swift > func readAll
    
    ///  "User,User2" → ["User","User2"]  convert
    public func convertJoinStringToList(joinMember:String) -> Array<String>{
        var members:Array<String> = []
        let result = joinMember.split(separator: ",")
        for item in result{
            members.append(String(item))
        }
        return members
    }
    
    
    /// Array<String> → RealmSwift.List<String> convert
    public func convertMembersToList(_ members:[String]) -> RealmSwift.List<String>{
        var filteringMembers = members.filter { !$0.isEmpty && !$0.trimmingCharacters(in: .whitespaces).isEmpty }
        if filteringMembers.count == 0 {
            filteringMembers = [""]
        }
        let memberList:RealmSwift.List = RealmSwift.List<String>()
        memberList.append(objectsIn: filteringMembers)
        return memberList
    }
    
    

    

    // MARK: - Travel(Realm)を更新する際のID変換
    // - String    → ObjectId
    // - 使用箇所：SwitchingDatabaseViewModel.swift
    /// ID:String → ID:ObjectId convert
    public func convertStringToObjectId(strID:String) -> RealmSwift.ObjectId {
        return try! ObjectId(string: strID)
    }
    
}
