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
    
    private let convertTypeVM = ConvertTypeViewModel()
    private let displayDateVM = DisplayDateViewModel()
    
    // MARK: - User
    /// User登録処理
    public func createUser(userId:String,name:String){
        ref.child("users").child(userId).child("username").setValue(name)
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
    
//    /// サインインUserが読み取り可能なTarvelID配列を観測
//    public func observeUserReadableTravelIds(userId:String,completion: @escaping ([String]) -> Void ) {
//        if !userId.isEmpty {
//            ref.child("users").child(userId).child("sharedTravelId").observe(.value) { snapshot in
//                if let currentUserReadableTravelId = snapshot.value as? [String] {
//                    completion(currentUserReadableTravelId)
//                }
//            }
//        }
//    }
    
    /// Create
    public func entryTravel(id:String,childUpdates:[String : Any]){
        ref.child("travels").child(id).updateChildValues(childUpdates)
    }
    
    
    // Read
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
                                let newSchedule = Schedule()
                                newSchedule.id = convertTypeVM.convertStringToObjectId(strID: schedule.key)
                                newSchedule.content = value["content"]!
                                newSchedule.memo = value["memo"]!
                                newSchedule.dateTime = displayDateVM.getAllDateStringDate(value["dateTime"]!)
                                newSchedule.type = ScheduleType.getScheduleType(value["type"]!)
                                newSchedule.tranceportation = Tranceportation.getScheduleType(value["tranceportation"]!)
                                schedulesArray.append(newSchedule)
                            } // #6
                        } // #5
                    } // #4 ↓schedulesがなくてもFirebaseに格納する
                    let newTravel = Travel()
                    newTravel.id = convertTypeVM.convertStringToObjectId(strID: travelRecored.key)
                    newTravel.name = travel["name"] as! String
                    newTravel.members = convertTypeVM.convertMembersToList(travel["members"]! as! Array<String>)
                    newTravel.startDate = displayDateVM.getAllDateStringDate(travel["startDate"]! as! String)
                    newTravel.endDate = displayDateVM.getAllDateStringDate(travel["endDate"]! as! String)
                    newTravel.schedules = schedulesArray
                    newTravel.share = true
                    newTravel.readableUserlId = travel["readableUserlId"]! as! Array<String>
                    TravelsArray.append(newTravel)
                } // #3
            } // #2
        } // #1
        completion(TravelsArray.sorted(by:{ $0.startDate > $1.startDate }))
    }
    
    // Update
    public func addSchedule(travelId:String,currentSchedules:List<Schedule>,addSchedule:Schedule){
        currentSchedules.append(addSchedule)
        
        let scheduleRef = ref.child("travels").child(travelId).child("schedules")
        let scheduleDictionary = convertTypeVM.convertScheduleToDictionary(schedules: currentSchedules)

        scheduleRef.setValue(scheduleDictionary)
    }
    
    // Update
    public func updateSchedule(travelId:String,newRecord:Schedule){
        let scheduleRef = ref.child("travels").child(travelId).child("schedules").child(newRecord.id.stringValue)
        let schedulesArray:RealmSwift.List<Schedule> = RealmSwift.List()
        schedulesArray.append(newRecord)
        let scheduleDictionary = convertTypeVM.convertScheduleToDictionary(schedules: schedulesArray)
        scheduleRef.setValue(scheduleDictionary.first?.value)

    }
    
    // Update
    public func updateTravel(newRecord:Travel,childUpdates:[String : Any]){
        ref.child("travels").child(newRecord.id.stringValue).updateChildValues(childUpdates)
    }
    
    // Delete
    public func deleteTravel(id:String) {
        ref.child("travels").child(id).removeValue()
    }
    
    public func deleteSchedule(travelId:String,scheduleId:String){
        ref.child("travels").child(travelId).child("schedules").child(scheduleId).removeValue()
    }

    public func deleteAllTable(userId:String){
        // Dataの前に読み取れるTravelIdを空にする
        ref.child("users").child(userId).child("sharedTravelId").removeValue()
    }
    // Travelを観測開始
    public func observedTravel(travelId:String,completion: @escaping ([Travel]) -> Void ) {
        ref.child("travels").child(travelId).observe(DataEventType.value, with: { snapshot in
            /// 必要になる変数を定義
            var TravelsArray:[Travel] = []
            let schedulesArray:RealmSwift.List<Schedule> = RealmSwift.List()
            
            if let travel = snapshot.value as? [String:Any]{           // #3 [travel.name,travel....]
                if let schedules = travel["schedules"] as? [String:Any] {   // #4 travel.schedulesが存在すれば
                    for schedule in schedules {                             // #5 格納されているscheduleだけ繰り返す
                        if let value = schedule.value as? [String:String] { // #6
                            let newSchedule = Schedule()
                            newSchedule.id = self.convertTypeVM.convertStringToObjectId(strID: schedule.key)
                            newSchedule.content = value["content"]!
                            newSchedule.memo = value["memo"]!
                            newSchedule.dateTime = self.displayDateVM.getAllDateStringDate(value["dateTime"]!)
                            newSchedule.type = ScheduleType.getScheduleType(value["type"]!)
                            newSchedule.tranceportation = Tranceportation.getScheduleType(value["tranceportation"]!)
                            schedulesArray.append(newSchedule)
                        } // #6
                    } // #5
                } // #4 ↓schedulesがなくてもFirebaseに格納する
                let newTravel = Travel()
        
                newTravel.id = self.convertTypeVM.convertStringToObjectId(strID: snapshot.key)
                newTravel.name = travel["name"] as! String
                newTravel.members = self.convertTypeVM.convertMembersToList(travel["members"]! as! Array<String>)
                newTravel.startDate = self.displayDateVM.getAllDateStringDate(travel["startDate"]! as! String)
                newTravel.endDate = self.displayDateVM.getAllDateStringDate(travel["endDate"]! as! String)
                newTravel.schedules = schedulesArray
                newTravel.share = true
                newTravel.readableUserlId = travel["readableUserlId"]! as! Array<String>
                TravelsArray.append(newTravel)
            } // #3
            completion(TravelsArray.sorted(by:{ $0.startDate > $1.startDate }))
        })
    }
    
    // 全てのデータベース観測を停止
    public func stopAllObserved(){
        ref.removeAllObservers()
    }
    
    public func registerAllRealmDBWithFirebase(childUpdates:[String : Any]){
        ref.child("travels").updateChildValues(childUpdates)
    }
}
