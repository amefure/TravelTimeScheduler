//
//  RealmDatabaseModel.swift
//  TravelTimeScheduler
//
//  Created by t&a on 2023/04/13.
//

import UIKit
import RealmSwift

class RealmDatabaseModel {
    
    static var shared:RealmDatabaseModel = RealmDatabaseModel()
    
    init() {
        let config = Realm.Configuration(schemaVersion: 1)
        realm = try! Realm(configuration:config)
    }
    
    //MARK: -  通知管理用RealmDBのCRUD処理モデル
    private var realm:Realm!
 
    // MARK: - Travel
    // Create
    public func createTravel(record:Travel){
        try! realm.write {
            realm.add(record)
        }
    }
    
    // Read
    public func readIdTravel(id:ObjectId) -> Travel{
        return realm.objects(Travel.self).where({$0.id == id}).first!
    }
    
    // Read
    public func readAllTravel() -> Results<Travel>{
        return realm.objects(Travel.self)
    }
    
    // Update
    public func addSchedule(id:ObjectId,schedule:Schedule){
        try! realm.write {
            let record = readIdTravel(id:id)
            record.schedules.append(schedule)
        }
    }
    
    // Update
    public func updateSchedule(travelId:ObjectId,scheduleId:ObjectId,dateTime:Date,content:String,memo:String,type:ScheduleType,tranceportation:Tranceportation?){
        try! realm.write {
            let record = readIdTravel(id:travelId)
            let result =  record.schedules.where({$0.id == scheduleId }).first!
            result.dateTime = dateTime
            result.content = content
            result.memo = memo
            result.type = type
            result.tranceportation = tranceportation
        }
    }
    
    // Update
    public func updateTravel(newRecord:Travel){
        try! realm.write {
            let record = readIdTravel(id: newRecord.id)
            record.name = newRecord.name
            record.members = newRecord.members
            record.startDate = newRecord.startDate
            record.endDate = newRecord.endDate
            record.share = newRecord.share
        }
    }
    
    // Delete
    public func deleteTravel(id:ObjectId) {
        try! realm.write{
            let record = readIdTravel(id:id)
            realm.delete(record)
        }
    }
    
    public func deleteSchedule(travelId:ObjectId,scheduleId:ObjectId){
        try! realm.write{
            let record = readIdTravel(id:travelId)
            let result =  record.schedules.where({$0.id == scheduleId }).first!
            realm.delete(result)
        }
    }
    
    // MARK: -
    public func deleteAllTable(){
        try! realm.write{
            realm.deleteAll()
        }
    }
}
