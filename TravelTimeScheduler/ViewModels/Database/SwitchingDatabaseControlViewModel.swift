//
//  SwitchingDatabaseViewModel.swift
//  TravelTimeScheduler
//
//  Created by t&a on 2023/05/20.
//

import SwiftUI
import RealmSwift

// MARK: - DBのSwitching & 適切なデータへの変換
class SwitchingDatabaseControlViewModel: CrudDatabaseViewModel {    
    
    // MARK: - Generic Type
    typealias RecordId = String
    typealias DBMembersCollection = Array<String>
    typealias DBScheduleCollection = RealmSwift.List<Schedule>
    
    
    // MARK: -  ViewModels
    /// DBに格納時にデータのタイプをキャストする機能を提供するViewModels
    private let convertTypeUtility = ConvertTypeUtility()
    /// サインインしているならFirebaseに切り替える
    private let authVM:AuthViewModel = AuthViewModel.shared
    
    
    // MARK: - CRUD処理を提供するViewModels
    private let realmVM = RealmDatabaseViewModel.shared
    private let fbVM = FBDatabaseViewModel.shared
    
    
    
    // MARK: -  Travel
    func createTravel(travelName: String, members: Array<String>, startDate: Date, endDate: Date) -> String {
        if authVM.isSignIn {
            return fbVM.createTravel(travelName: travelName, members: members, startDate: startDate, endDate: endDate)
        } else {
            let membersList = convertTypeUtility.convertMembersToList(members)
            return realmVM.createTravel(travelName: travelName, members: membersList, startDate: startDate, endDate: endDate)
        }
        
    }
    
    
    /// Update  Property
    public func updateTravel(id:String,travelName:String,members:Array<String>,startDate:Date,endDate:Date,schedules:RealmSwift.List<Schedule>){
        if authVM.isSignIn {
            let scheduleDictionary = convertTypeUtility.convertScheduleToDictionary(schedules:schedules)
            fbVM.updateTravel(id: id, travelName: travelName, members: members, startDate: startDate, endDate: endDate, schedules: scheduleDictionary)
        }else{
            let objID = convertTypeUtility.convertStringToObjectId(strID: id)
            let membersList = convertTypeUtility.convertMembersToList(members)
            realmVM.updateTravel(id: objID, travelName: travelName, members: membersList, startDate: startDate, endDate: endDate, schedules: schedules)
        }
    }
    
    // Delete
    public func deleteTravel(travel:Travel){
        if authVM.isSignIn {
            fbVM.deleteTravel(travel: travel)
        }else{
            realmVM.deleteTravel(travel: travel)
        }
    }
    
    
    // MARK: - Schedule
    // Update
    public func addSchedule(travel:Travel,schedule:Schedule){
        if authVM.isSignIn {
            fbVM.addSchedule(travel: travel, schedule: schedule)
        }else{
            realmVM.addSchedule(travel: travel, schedule: schedule)
        }
    }
    
    // Update
    public func updateSchedule(travelId:String,scheduleId:String,dateTime:Date ,endDateTime:Date? ,content:String,memo:String,type:ScheduleType,tranceportation:Tranceportation?){
        if authVM.isSignIn {
            fbVM.updateSchedule(travelId: travelId, scheduleId: scheduleId, dateTime: dateTime, endDateTime: endDateTime, content: content, memo:memo, type: type, tranceportation: tranceportation)
        }else{
            let objTravelID = convertTypeUtility.convertStringToObjectId(strID: travelId)
            let objScheduleID = convertTypeUtility.convertStringToObjectId(strID: scheduleId)
            realmVM.updateSchedule(travelId: objTravelID, scheduleId: objScheduleID, dateTime: dateTime, endDateTime: endDateTime, content: content, memo:memo, type: type, tranceportation: tranceportation)
        }
    }
    
    // Delete
    public func deleteSchedule(travelId:String,scheduleId:String){
        if authVM.isSignIn {
            fbVM.deleteSchedule(travelId: travelId, scheduleId: scheduleId)
        }else{
            let objTravelID = convertTypeUtility.convertStringToObjectId(strID: travelId)
            let objScheduleID = convertTypeUtility.convertStringToObjectId(strID: scheduleId)
            realmVM.deleteSchedule(travelId: objTravelID, scheduleId: objScheduleID)
        }
        
    }
    


}

// MARK: - Realm Only Function
extension SwitchingDatabaseControlViewModel{
    
    // MARK: - ALl
    public func deleteRealmAllTable() {
        realmVM.deleteAllTable()
    }
    
}

// MARK: - Firebase Only Function
extension SwitchingDatabaseControlViewModel {
    
    // MARK: - ALl
    public func deleteFBAllTable() {
        fbVM.deleteAllTable()
    }
    
    // MARK: - User
    /// User新規登録時にDBに情報を格納
    public func createUser(userId:String,name:String){
        fbVM.createUser(userId:userId, name: name)
    }
    
    /// Tarvelを読み取れるサインインUser ID配列を更新
    public func updateTravelReadableUserId(userId:String,travelId:String){
        fbVM.updateTravelReadableUserId(userId:userId,travelId:travelId)
    }
    
    /// Travel共有時にUser内にtravelIdを格納
    public func readAllTravel(completion: @escaping ([Travel]) -> Void ) {
        fbVM.readAllTravel { data in
            completion(data)
        }
    }
    
    public func observedTravel(travelId:String,completion: @escaping (Travel) -> Void ) {
        fbVM.observedTravel(travelId: travelId) { data in
            completion(data)
        }
    }
    
    // 全てのデータベース観測を停止
    public func stopAllObserved(){
        fbVM.stopAllObserved()
    }
}

// MARK: - SignIn/Out Fuction
extension SwitchingDatabaseControlViewModel {
    // MARK: - SingIn
    /// User新規登録時にDBに情報を格納
    public func registerAllRealmDBWithFirebase(travels:Results<Travel>){
        fbVM.registerAllRealmDBWithFirebase(travels:Array(travels))
    }
    
}
