//
//  CrudDatabaseViewModel.swift
//  TravelTimeScheduler
//
//  Created by t&a on 2023/05/22.
//

import UIKit

protocol CrudDatabaseViewModel {
    
    // MARK: - Generic Type
    associatedtype RecordId             // String          or RealmSwift.ObjectId
    associatedtype DBMembersCollection  // Array<String>   or RealmSwift.List<String>
    associatedtype DBScheduleCollection // Array<Schedule> or RealmSwift.List<Schedule>
    
    // MARK: -  Travel
    func createTravel(travelName:String,members:DBMembersCollection,startDate:Date,endDate:Date)
    func updateTravel(id:RecordId,travelName:String,members:DBMembersCollection,startDate:Date,endDate:Date,schedules:DBScheduleCollection)
    func updateShareTravel(travel:Travel,share:Bool)
    func deleteTravel(id:RecordId)
    
    // MARK: -  Schedule
    func addSchedule(travel:Travel,schedule:Schedule)
    func updateSchedule(travelId:RecordId,scheduleId:RecordId,dateTime:Date,content:String,memo:String,type:ScheduleType,tranceportation:Tranceportation?)
    func deleteSchedule(travelId:RecordId,scheduleId:RecordId)
    
    // MARK: -  All
    func deleteAllTable()
}
