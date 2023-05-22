//
//  RealmDatabaseViewModel.swift
//  TravelTimeScheduler
//
//  Created by t&a on 2023/04/13.
//

import UIKit
import RealmSwift

///RealmDBのCRUD処理ViewModel
class RealmDatabaseViewModel:CrudDatabaseViewModel {
    
    // MARK: - Generic Type
    typealias RecordId = ObjectId
    typealias DBMembersCollection = List<String>
    typealias DBScheduleCollection = List<Schedule>
    
    // MARK: - Models
    private let model = RealmDatabaseModel.shared

    // MARK: シングルトン
    static let shared:RealmDatabaseViewModel = RealmDatabaseViewModel()
    
    // MARK: - Travel
    /// Create
    public func createTravel(travelName: String, members: List<String>, startDate: Date, endDate: Date) {
        let record = Travel()
        record.name = travelName
        record.members = members
        record.startDate = startDate
        record.endDate = endDate
       
        model.createTravel(record: record)
    }
    
    /// Update  Property
    public func updateTravel(id:ObjectId,travelName:String,members:List<String>,startDate:Date,endDate:Date,schedules:List<Schedule>){
        let newRecord = Travel()
        newRecord.id = id
        newRecord.name = travelName
        newRecord.members = members
        newRecord.startDate = startDate
        newRecord.endDate = endDate
        newRecord.schedules = schedules
        model.updateTravel(newRecord: newRecord)
    }
    
    /// Update Share Property Only
    public func updateShareTravel(travel:Travel,share:Bool){
        let newRecord = Travel()
        newRecord.id = travel.id
        newRecord.name = travel.name
        newRecord.members = travel.members
        newRecord.startDate = travel.startDate
        newRecord.endDate = travel.endDate
        newRecord.schedules = travel.schedules
        newRecord.share = share
        model.updateTravel(newRecord: newRecord)
    }
    
    // Delete
    public func deleteTravel(id:ObjectId){
        model.deleteTravel(id: id)
    }
    
    // MARK: - Schedule
    // Create(add)
    public func addSchedule(id:ObjectId,schedule:Schedule){
        model.addSchedule(id: id, schedule: schedule)
    }
    
    // Update
    public func updateSchedule(travelId:ObjectId,scheduleId:ObjectId,dateTime:Date,content:String,memo:String,type:ScheduleType,tranceportation:Tranceportation?){
        model.updateSchedule(travelId: travelId,
                             scheduleId: scheduleId,
                             dateTime: dateTime,
                             content: content,
                             memo:memo,
                             type: type,
                             tranceportation: tranceportation)
    }
    
    // Delete
    public func deleteSchedule(travelId:ObjectId,scheduleId:ObjectId){
        model.deleteSchedule(travelId: travelId, scheduleId: scheduleId)
    }
    
    // MARK: - All
    /// 保存している全てのテーブルを削除する
    public func deleteAllTable(){
        model.deleteAllTable()
    }
    
}
