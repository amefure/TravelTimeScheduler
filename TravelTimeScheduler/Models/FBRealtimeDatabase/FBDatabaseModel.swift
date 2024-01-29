//
//  FBDatabaseModel.swift
//  TravelTimeScheduler
//
//  Created by t&a on 2023/05/16.
//

import UIKit
import FirebaseDatabase
import RealmSwift

class FBDatabaseModel {
    
    static var shared:FBDatabaseModel = FBDatabaseModel()
    
    // MARK: - Database Reference
    private var ref:DatabaseReference! = Database.database().reference()
    
    private let convertTypeUtility = ConvertTypeUtility()
    private let displayDateVM = DateFormatManager()
    
    // MARK: - User
    /// User登録処理
    public func createUser(userId:String,name:String){
        ref.child("users").child(userId).child("username").setValue(name)
    }
    
    // MARK: - Tarvel
    
    /// Create Tarvel
    public func entryTravel(id:String,childUpdates:[String : Any]){
        ref.child("travels").child(id).updateChildValues(childUpdates)
    }
    
    /// Read Tarvel
    public func readAllTravel(completion: @escaping ([Travel]) -> Void ) {
        ref.child("travels").getData(completion:  { error, snapshot in
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
            self.setSnapShot(snapshot!) { data in
                completion(data)
            }
        })
    }
    
    /// Update Tarvel
    public func updateTravel(newRecord:Travel,childUpdates:[String : Any]){
        ref.child("travels").child(newRecord.id.stringValue).updateChildValues(childUpdates)
    }
    
    /// Delete Tarvel
    public func deleteTravel(travel:Travel,userId:String) {
        var ids = travel.readableUserlId
        if ids.count == 1{
            ref.child("travels").child(travel.id.stringValue).removeValue()
        }else{
            let index = ids.firstIndex(of: userId)
            ids.remove(at: index!)
            ref.child("travels").child(travel.id.stringValue).child("readableUserlId").setValue(ids)
        }
    }
    
    /// Tarvelを読み取れるサインインUser ID配列を更新
    public func updateTravelReadableUserId(userId:String,travelId:String){
        let userRef = ref.child("travels").child(travelId).child("readableUserlId")
        userRef.getData(completion:  { error, snapshot in
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
            if var array = snapshot?.value as? [String] {
                array.append(userId)
                userRef.setValue(array)
            }else{
                userRef.setValue([userId])
            }
        })
    }
    
    // MARK: - Schedule
    /// Create Schedule
    public func addSchedule(travelId:String,currentSchedules:List<Schedule>,addSchedule:Schedule){
        currentSchedules.append(addSchedule)
        
        let scheduleRef = ref.child("travels").child(travelId).child("schedules")
        let scheduleDictionary = convertTypeUtility.convertScheduleToDictionary(schedules: currentSchedules)

        scheduleRef.setValue(scheduleDictionary)
    }
    
    /// Update Schedule
    public func updateSchedule(travelId:String,newRecord:Schedule){
        let scheduleRef = ref.child("travels").child(travelId).child("schedules").child(newRecord.id.stringValue)
        let schedulesArray:RealmSwift.List<Schedule> = RealmSwift.List()
        schedulesArray.append(newRecord)
        let scheduleDictionary = convertTypeUtility.convertScheduleToDictionary(schedules: schedulesArray)
        scheduleRef.setValue(scheduleDictionary.first?.value)

    }
    
    /// Delete Schedule
    public func deleteSchedule(travelId:String,scheduleId:String){
        ref.child("travels").child(travelId).child("schedules").child(scheduleId).removeValue()
    }

    // MARK: - All
    /// 退会時にユーザーに紐づいている情報を削除する
    public func deleteAllTable(userId:String){
        self.readAllTravel { travels in
            let result = travels.filter({$0.readableUserlId.contains(userId)})
            for travel in result{
                self.deleteTravel(travel: travel, userId: userId)
            }
        }
        ref.child("users").child(userId).removeValue()
    }

}

// データ変換　privateメソッド
extension FBDatabaseModel{
    
    // MARK: - Convert Snapshot to Class convert
    private func setSnapShot(_ snapshot:DataSnapshot,completion: @escaping ([Travel]) -> Void ) {
        
        /// 必要になる変数を定義
        var TravelsArray:[Travel] = []
        let schedulesArray:RealmSwift.List<Schedule> = RealmSwift.List()
        
        /// 掘り進める
        if let travels = snapshot.value as? [String:Any]{                       // #1 [ key-travel.id : value [travel.name,travel....]]
            for travelRecored in travels {                                      // #2 格納されているRecordだけ繰り返す
                if let travel = travelRecored.value as? [String:Any]{           // #3 [travel.name,travel....]
                    if let schedules = travel["schedules"] as? [String:Any] {   // #4 travel.schedulesが存在すれば
                        for schedule in schedules {                             // #5 格納されているscheduleだけ繰り返す
                            if let value = schedule.value as? [String:String] { // #6
                                let newSchedule = self.getConvertSchedule(key: schedule.key, value: value)
                                schedulesArray.append(newSchedule)
                            } // #6
                        } // #5
                    } // #4 ↓schedulesがなくてもFirebaseに格納する
                    let newTravel = self.getConvertTravel(key: travelRecored.key, travel: travel, schedulesArray: schedulesArray)
                    TravelsArray.append(newTravel)
                    // 中身をリセット
                    schedulesArray.removeAll()
                } // #3
            } // #2
        } // #1
        completion(TravelsArray.sorted(by:{ $0.name > $1.name }).sorted(by:{ $0.startDate > $1.startDate }))
    }
    
    private func getConvertTravel(key:String,travel:[String:Any],schedulesArray:List<Schedule>) -> Travel{
        let newTravel = Travel()
        newTravel.id = self.convertTypeUtility.convertStringToObjectId(strID: key)
        newTravel.name = travel["name"] as! String
        newTravel.members = self.convertTypeUtility.convertMembersToList(travel["members"]! as! Array<String>)
        newTravel.startDate = self.displayDateVM.getAllDateStringDate(travel["startDate"]! as! String)
        newTravel.endDate = self.displayDateVM.getAllDateStringDate(travel["endDate"]! as! String)
        newTravel.schedules = schedulesArray
        newTravel.share = true
        newTravel.readableUserlId = travel["readableUserlId"]! as! Array<String>
        return newTravel
    }
    
    private func getConvertSchedule(key:String,value:[String:String]) -> Schedule{
        let newSchedule = Schedule()
        newSchedule.id = self.convertTypeUtility.convertStringToObjectId(strID: key)
        newSchedule.content = value["content"]!
        newSchedule.memo = value["memo"]!
        newSchedule.dateTime = self.displayDateVM.getAllDateStringDate(value["dateTime"]!)
        if value["endDateTime"] != nil && value["endDateTime"] != ""{
            newSchedule.endDateTime = self.displayDateVM.getAllDateStringDate(value["endDateTime"]!)
        }
        newSchedule.type = ScheduleType.getScheduleType(value["type"]!)
        newSchedule.tranceportation = Tranceportation.getScheduleType(value["tranceportation"]!)
        return newSchedule
    }
    
}

// Oserved
extension FBDatabaseModel{
    // Travelを観測開始
    public func observedTravel(travelId:String,completion: @escaping (Travel) -> Void ) {
        ref.child("travels").child(travelId).observe(DataEventType.value, with: { snapshot in
            /// 必要になる変数を定義
            var newTravel = Travel()
            let schedulesArray:RealmSwift.List<Schedule> = RealmSwift.List()
            
            if let travel = snapshot.value as? [String:Any]{           // #3 [travel.name,travel....]
                if let schedules = travel["schedules"] as? [String:Any] {   // #4 travel.schedulesが存在すれば
                    for schedule in schedules {                             // #5 格納されているscheduleだけ繰り返す
                        if let value = schedule.value as? [String:String] { // #6
                            let newSchedule = self.getConvertSchedule(key: schedule.key, value: value)
                            schedulesArray.append(newSchedule)
                        } // #6
                    } // #5
                } // #4 ↓schedulesがなくてもFirebaseに格納する
                newTravel = self.getConvertTravel(key: snapshot.key, travel: travel, schedulesArray: schedulesArray)
            } // #3
            completion(newTravel)
        })
    }
    
    // 全てのデータベース観測を停止
    public func stopAllObserved(){
        ref.removeAllObservers()
    }
    
}

// 新規登録時にRealmのデータをすべて保存する
extension FBDatabaseModel {
     public func registerAllRealmDBWithFirebase(childUpdates:[String : Any]){
         ref.child("travels").updateChildValues(childUpdates)
     }
}
