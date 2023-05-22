//
//  SwitchingDatabaseViewModel.swift
//  TravelTimeScheduler
//
//  Created by t&a on 2023/05/20.
//

import SwiftUI
import RealmSwift

// MARK: - DBのSwitching & 適切なデータへの変換
class SwitchingDatabaseControlViewModel:CrudDatabaseViewModel {    
    
    // MARK: - Generic Type
    typealias RecordId = String
    typealias DBMembersCollection = Array<String>
    typealias DBScheduleCollection = RealmSwift.List<Schedule>
    
    
    // MARK: -  ViewModels
    /// DBに格納時にデータのタイプをキャストする機能を提供するViewModels
    private let convertTypeVM = ConvertTypeViewModel()
    /// アクティブになっているDB状態
    private let dbStatus: CurrentDatabaseStatusViewModel = CurrentDatabaseStatusViewModel.shared
    
    // MARK: シングルトン
    static let shared:SwitchingDatabaseControlViewModel = SwitchingDatabaseControlViewModel()
    
    // MARK: - CRUD処理を提供するViewModels
    private let realmVM = RealmDatabaseViewModel.shared
    private let fbVM = FBDatabaseViewModel.shared

    
    
    // MARK: -  Travel
    func createTravel(travelName: String, members: Array<String>, startDate: Date, endDate: Date) {
            let membersList = convertTypeVM.convertMembersToList(members)
            realmVM.createTravel(travelName: travelName, members: membersList, startDate: startDate, endDate: endDate)

    }
    
    
    /// Update  Property
    public func updateTravel(id:String,travelName:String,members:Array<String>,startDate:Date,endDate:Date,schedules:RealmSwift.List<Schedule>){
        if dbStatus.isFB {
            let array:Array<Schedule> =  Array(schedules)
            fbVM.updateTravel(id: id, travelName: travelName, members: members, startDate: startDate, endDate: endDate, schedules: array)
        }else{
            let objID = convertTypeVM.convertStringToObjectId(strID: id)
            let membersList = convertTypeVM.convertMembersToList(members)
            realmVM.updateTravel(id: objID, travelName: travelName, members: membersList, startDate: startDate, endDate: endDate, schedules: schedules)
        }
    }
    
    /// Update Share Property Only
    public func updateShareTravel(travel:Travel,share:Bool){
        if dbStatus.isFB {
            fbVM.updateShareTravel(travel: travel, share: true)
        }else{
            realmVM.updateShareTravel(travel: travel, share: true)
        }
    }
    
    
    // Delete
    public func deleteTravel(id:String){
        if dbStatus.isFB {
            fbVM.deleteTravel(id: id)
        }else{
            let objID = convertTypeVM.convertStringToObjectId(strID: id)
            realmVM.deleteTravel(id: objID)
        }
    }
    
    
    // MARK: - Schedule
    // Update
    public func addSchedule(id:String,schedule:Schedule){
        if dbStatus.isFB {
            fbVM.addSchedule(id: id, schedule: schedule)
        }else{
            let objID = convertTypeVM.convertStringToObjectId(strID: id)
            realmVM.addSchedule(id: objID, schedule: schedule)
        }
    }

    // Update
    public func updateSchedule(travelId:String,scheduleId:String,dateTime:Date,content:String,memo:String,type:ScheduleType,tranceportation:Tranceportation?){
        if dbStatus.isFB {
            fbVM.updateSchedule(travelId: travelId, scheduleId: scheduleId, dateTime: dateTime, content: content, memo:memo, type: type, tranceportation: tranceportation)
        }else{
            let objTravelID = convertTypeVM.convertStringToObjectId(strID: travelId)
            let objScheduleID = convertTypeVM.convertStringToObjectId(strID: scheduleId)
            realmVM.updateSchedule(travelId: objTravelID, scheduleId: objScheduleID, dateTime: dateTime, content: content, memo:memo, type: type, tranceportation: tranceportation)
        }
    }

    // Delete
    public func deleteSchedule(travelId:String,scheduleId:String){
        if dbStatus.isFB {
            fbVM.deleteSchedule(travelId: travelId, scheduleId: scheduleId)
        }else{
            let objTravelID = convertTypeVM.convertStringToObjectId(strID: travelId)
            let objScheduleID = convertTypeVM.convertStringToObjectId(strID: travelId)
            realmVM.deleteSchedule(travelId: objTravelID, scheduleId: objScheduleID)
        }

    }
    
    // MARK: - ALl
    public func deleteAllTable() {
        if dbStatus.isFB {
            fbVM.deleteAllTable()
        }else{
            realmVM.deleteAllTable()
        }
    }
}

// MARK: - Firebase Only Function
extension SwitchingDatabaseControlViewModel {
    
    // MARK: - User
    /// User新規登録時にDBに情報を格納
    public func createUser(userId:String,name:String){
        fbVM.createUser(userId:userId, name: name)
    }
    
    // MARK: - User
    /// User新規登録時にDBに情報を格納
    public func entryTravel(travel:Travel){
        let membersString = convertTypeVM.convertMembersToJoinString(members: travel.members)
        let scheduleDictionary = convertTypeVM.convertScheduleToDictionary(schedules: travel.schedules)
        let childUpdates:[String : Any] = [
            "name": travel.name,
            "members": membersString,
            "schedules" : scheduleDictionary,
            "startDate": DisplayDateViewModel().getAllDateDisplayFormatString(travel.startDate),
            "endDate": DisplayDateViewModel().getAllDateDisplayFormatString(travel.endDate),
            "share": "true"
        ]
        fbVM.entryTravel(id:travel.id.stringValue,childUpdates: childUpdates)
    }
    
    /// User新規登録時にDBに情報を格納
    public func readAllTravel(){
        fbVM.readAllTravel()
    }
}

