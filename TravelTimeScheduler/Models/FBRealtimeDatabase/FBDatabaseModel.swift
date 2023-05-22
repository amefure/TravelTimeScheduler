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
    
    // MARK: - User
    /// User登録処理
    public func createUser(userId:String,name:String){
        ref.child("users").child(userId).setValue(["username": name])
    }
    /// User登録処理
    public func addTravelIdSharedByUser(userId:String,travelId:String){
        let userRef = ref.child("users").child(userId).child("sharedId")
        userRef.getData(completion:  { error, snapshot in
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
            if var array = snapshot?.value as? [String] {
                    // 配列の操作を行う
                    array.append(travelId)
                    
                    // 更新した配列をデータベースに保存
                userRef.setValue(array)
            }else{
                userRef.setValue([travelId])
            }
            
        })
    }
    
    ///  "User,User2" → ["User","User2"]  convert
    private func convertMembersList(joinMember:String) -> RealmSwift.List<String>{
        let members:RealmSwift.List<String> = RealmSwift.List()
        let result = joinMember.split(separator: ",")
        for item in result{
            members.append(String(item))
        }
        return members
    }

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
        if let travels = snapshot.value as? [String:Any]{ // [ key-travel.id : value [travel.name,travel....]]
            if let travel = travels.first!.value as? [String:Any]{ // [travel.name,travel....]
                if let schedules = travel["schedules"] as? [String:Any] {
                    for schedule in schedules {
                        if let value = schedule.value as? [String:String] {
                            let newSchedule = Schedule()
                            newSchedule.id = try! ObjectId(string: schedule.key)
                            newSchedule.content = value["content"]!
                            newSchedule.memo = value["memo"]!
                            newSchedule.dateTime = DisplayDateViewModel().getAllDateStringDate(value["dateTime"]!)
                            newSchedule.type = ScheduleType.getScheduleType(value["type"]!)
                            newSchedule.tranceportation = Tranceportation.getScheduleType(value["tranceportation"]!)
                            schedulesArray.append(newSchedule)
                        }
                    }
                    let newTravel = Travel()
                    newTravel.id = try! ObjectId(string: travels.first!.key)
                    newTravel.name = travel["name"] as! String
                    newTravel.members = self.convertMembersList(joinMember: travel["members"]! as! String)
                    newTravel.startDate = DisplayDateViewModel().getAllDateStringDate(travel["startDate"]! as! String)
                    newTravel.endDate = DisplayDateViewModel().getAllDateStringDate(travel["endDate"]! as! String)
                    newTravel.schedules = schedulesArray
                    newTravel.share = true
                    TravelsArray.append(newTravel)
                    completion(TravelsArray)
                }
            }
        }
    }
    
    // Update
    public func addSchedule(id:ObjectId,schedule:Schedule){
        
    }
    
    // Update
    public func updateSchedule(travelId:ObjectId,scheduleId:ObjectId,dateTime:Date,content:String,memo:String,type:ScheduleType,tranceportation:Tranceportation?){
        
    }
    
    // Update
    public func updateTravel(newRecord:Travel){
        
    }
    
    // Delete
    public func deleteTravel(id:ObjectId) {
        
    }
    public func deleteAllTravel() {
        
    }
    
    public func deleteSchedule(travelId:ObjectId,scheduleId:ObjectId){
        
    }

    
    
    
    // MARK: -
    public func deleteAllTable(){
    }
}
