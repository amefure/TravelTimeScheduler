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
        if dbStatus.isFB {
            fbVM.createTravel(travelName: travelName, members: members, startDate: startDate, endDate: endDate)
        }else{
            let membersList = convertTypeVM.convertMembersToList(members)
            realmVM.createTravel(travelName: travelName, members: membersList, startDate: startDate, endDate: endDate)
        }
        
    }
    
    
    /// Update  Property
    public func updateTravel(id:String,travelName:String,members:Array<String>,startDate:Date,endDate:Date,schedules:RealmSwift.List<Schedule>){
        if dbStatus.isFB {
            let scheduleDictionary = convertTypeVM.convertScheduleToDictionary(schedules:schedules)
            fbVM.updateTravel(id: id, travelName: travelName, members: members, startDate: startDate, endDate: endDate, schedules: scheduleDictionary)
        }else{
            let objID = convertTypeVM.convertStringToObjectId(strID: id)
            let membersList = convertTypeVM.convertMembersToList(members)
            realmVM.updateTravel(id: objID, travelName: travelName, members: membersList, startDate: startDate, endDate: endDate, schedules: schedules)
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
    public func addSchedule(travel:Travel,schedule:Schedule){
        if dbStatus.isFB {
            fbVM.addSchedule(travel: travel, schedule: schedule)
        }else{
            realmVM.addSchedule(travel: travel, schedule: schedule)
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
            let objScheduleID = convertTypeVM.convertStringToObjectId(strID: scheduleId)
            realmVM.deleteSchedule(travelId: objTravelID, scheduleId: objScheduleID)
        }
        
    }
    
    // MARK: - ALl
    public func deleteAllTable() {
//        if dbStatus.isFB {
//            fbVM.deleteAllTable()
//        }else{
//            realmVM.deleteAllTable()
//        }
    }

}

// MARK: - Realm Only Function
extension SwitchingDatabaseControlViewModel{
    
    /// Update Share Property Only
    public func updateShareTravel(travel:Travel,share:Bool){
        realmVM.updateShareTravel(travel: travel, share: true)
    }
    
    
    public func deleteRealmAllTable() {
        realmVM.deleteAllTable()
    }
    
}

// MARK: - Firebase Only Function
extension SwitchingDatabaseControlViewModel {
    
    // MARK: - User
    /// User新規登録時にDBに情報を格納
    public func createUser(userId:String,name:String){
        fbVM.createUser(userId:userId, name: name)
    }
    
    /// Travel共有時にUser内にtravelIdを格納
    public func addUserReadableTravelId(userId:String,travelId:String){
        fbVM.addUserReadableTravelId(userId:userId,travelId:travelId)
    }
    
    /// サインインUserが読み取り可能なTarvelID配列を観測
    public func observeUserReadableTravelIds(userId:String,completion: @escaping ([String]) -> Void ) {
        fbVM.observeUserReadableTravelIds(userId: userId) { data in
            completion(data)
        }
    }
    
    // MARK: - User
    /// User新規登録時にDBに情報を格納
    public func entryTravel(travel:Travel){
        fbVM.entryTravel(travel: travel)
    }
    
    /// User新規登録時にDBに情報を格納
    public func readAllTravel(completion: @escaping ([Travel]) -> Void ) {
        fbVM.readAllTravel { data in
            completion(data)
        }
    }
    
    public func observedTravel(travelId:String,completion: @escaping ([Travel]) -> Void ) {
        fbVM.observedTravel(travelId: travelId) { data in
            completion(data)
        }
    }
    
    // 全てのデータベース観測を停止
    public func stopAllObserved(){
        fbVM.stopAllObserved()
    }
}

