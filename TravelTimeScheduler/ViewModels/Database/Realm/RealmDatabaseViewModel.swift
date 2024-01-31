//
//  RealmDatabaseViewModel.swift
//  TravelTimeScheduler
//
//  Created by t&a on 2023/04/13.
//

import UIKit
import RealmSwift

///RealmDBのCRUD処理ViewModel
class RealmDatabaseViewModel: CrudDatabaseViewModel {
    
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
    public func createTravel(travelName: String, members: List<String>, startDate: Date, endDate: Date) -> String {
        let record = Travel()
        record.name = travelName
        record.members = members
        record.startDate = startDate
        record.endDate = endDate
       
        model.createTravel(record: record)
        return record.id.stringValue
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
    
    // Delete
    public func deleteTravel(travel:Travel){
        model.deleteTravel(id: travel.id)
    }
    
    // MARK: - Schedule
    // Create(add)
    public func addSchedule(travel:Travel,schedule:Schedule){
        model.addSchedule(id: travel.id, schedule: schedule)
    }
    
    // Update
    public func updateSchedule(travelId: ObjectId, scheduleId: ObjectId, dateTime: Date, endDateTime: Date?, content: String, memo: String, type: ScheduleType, tranceportation: Tranceportation?){
        model.updateSchedule(travelId: travelId,
                             scheduleId: scheduleId,
                             dateTime: dateTime,
                             endDateTime: endDateTime,
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
