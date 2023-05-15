//
//  RealmDatabaseViewModel.swift
//  TravelTimeScheduler
//
//  Created by t&a on 2023/04/13.
//

import UIKit
import RealmSwift

class RealmDatabaseViewModel {
    // MARK: -  通知管理用RealmDBのCRUD処理ViewModel
    
    // MARK: - Models
    private let model = RealmDatabaseModel()

    // MARK: - RealmSwift.List<String>へ変換
    private func convertMemberList(_ members:[String]) -> RealmSwift.List<String>{
        var filteringMembers = members.filter { !$0.isEmpty && !$0.trimmingCharacters(in: .whitespaces).isEmpty }
        if filteringMembers.count == 0 {
            filteringMembers = [""]
        }
        let memberList:RealmSwift.List = RealmSwift.List<String>()
        for member in filteringMembers {
            memberList.append(member)
        }
        return memberList
    }
    
    // MARK: -
    // Create
    public func createTravel(travelName:String,members:[String],startDate:Date,endDate:Date){
        let record = Travel()
        record.name = travelName
        record.members = convertMemberList(members)
        record.startDate = startDate
        record.endDate = endDate
        model.createTravel(record: record)
    }
    
    // Update
    public func addSchedule(id:ObjectId,schedule:Schedule){
        model.addSchedule(id: id, schedule: schedule)
    }
    
    // Update
    public func updateSchedule(travelId:ObjectId,scheduleId:ObjectId,dateTime:Date,content:String,type:ScheduleType,tranceportation:Tranceportation?){
        model.updateSchedule(travelId: travelId, scheduleId: scheduleId, dateTime: dateTime, content: content,  type: type, tranceportation: tranceportation)
    }
    
    // Update
    public func updateTravel(id:ObjectId,travelName:String,members:[String],startDate:Date,endDate:Date,schedules:List<Schedule>){
        let newRecord = Travel()
        newRecord.id = id
        newRecord.name = travelName
        newRecord.members = self.convertMemberList(members)
        newRecord.startDate = startDate
        newRecord.endDate = endDate
        newRecord.schedules = schedules
        model.updateTravel(newRecord: newRecord)
    }
    
    // Delete
    public func deleteTravel(id:ObjectId){
        model.deleteTravel(id: id)
    }
    
    // Delete
    public func deleteSchedule(travelId:ObjectId,scheduleId:ObjectId){
        model.deleteSchedule(travelId: travelId, scheduleId: scheduleId)
    }
    
    public func realmAllReset(){
        model.deleteAllTable()
    }
    
}
