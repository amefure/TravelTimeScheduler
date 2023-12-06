//
//  FBDatabaseViewModel.swift
//  TravelTimeScheduler
//
//  Created by t&a on 2023/04/07.
//

import UIKit
import FirebaseDatabase


class FBDatabaseViewModel:CrudDatabaseViewModel{
    
    // MARK: シングルトン
    static let shared:FBDatabaseViewModel = FBDatabaseViewModel()
    
    // MARK: - Models
    private let model = FBDatabaseModel()
    
    // MARK: -  ViewModels
    private let convertTypeVM = ConvertTypeViewModel()
    private let userInfoVM = SignInUserInfoViewModel()
    
    // MARK: - Generic Type
    typealias RecordId = String
    typealias DBMembersCollection = Array<String>
    typealias DBScheduleCollection = [String : [String : String]]//Array<Schedule>
    
    // MARK: - Travel新規登録
    public func createTravel(travelName: String, members: Array<String>, startDate: Date, endDate: Date) {
        let childUpdates:[String : Any] = [
            "name": travelName,
            "members": members,
            "startDate": DisplayDateViewModel().getAllDateDisplayFormatString(startDate),
            "endDate": DisplayDateViewModel().getAllDateDisplayFormatString(endDate),
            "share": "true",
            "readableUserlId": [userInfoVM.signInUserId]
        ]
        let id:String = convertTypeVM.generateObjectIdString()
        model.entryTravel(id:id ,childUpdates: childUpdates)
    }
    
    // MARK: - Travel更新
    public func updateTravel(id: String, travelName: String, members: Array<String>, startDate: Date, endDate: Date, schedules: [String : [String : String]]) {
        let childUpdates:[String : Any] = [
            "name": travelName,
            "members": Array(members),
            "schedules" : schedules,
            "startDate": DisplayDateViewModel().getAllDateDisplayFormatString(startDate),
            "endDate": DisplayDateViewModel().getAllDateDisplayFormatString(endDate),
            "share": "true"
        ]
        model.entryTravel(id:id,childUpdates: childUpdates)
    }
    
    public func deleteTravel(travel:Travel) {
        model.deleteTravel(travel: travel,userId: userInfoVM.signInUserId)
    }
    
    // MARK: - Schedule
    public func addSchedule(travel:Travel,schedule:Schedule){
        model.addSchedule(travelId: travel.id.stringValue, currentSchedules: travel.schedules, addSchedule: schedule)
    }
    
    public func updateSchedule(travelId: String, scheduleId: String, dateTime: Date, endDateTime:Date?, content: String, memo: String, type: ScheduleType, tranceportation: Tranceportation?) {
        let sc = Schedule()
        sc.id = convertTypeVM.convertStringToObjectId(strID: scheduleId)
        sc.content = content
        sc.dateTime = dateTime
        sc.endDateTime = endDateTime
        sc.memo = memo
        sc.type = type
        sc.tranceportation = tranceportation ?? .other
        model.updateSchedule(travelId: travelId, newRecord: sc)
        
    }
    
    public func deleteSchedule(travelId: String, scheduleId: String) {
        model.deleteSchedule(travelId: travelId, scheduleId: scheduleId)
    }
    
    // MARK: - All
    public func deleteAllTable() {
        model.deleteAllTable(userId: userInfoVM.signInUserId)
    }
    
}

extension FBDatabaseViewModel {
    // MARK: - User
    /// User新規登録時にDBに情報を格納
    public func createUser(userId:String,name:String){
        model.createUser(userId:userId, name: name)
    }
    /// Tarvelを読み取れるサインインUser ID配列を更新
    public func updateTravelReadableUserId(userId:String,travelId:String){
        model.updateTravelReadableUserId(userId:userId,travelId:travelId)
    }
    
    // MARK: - Travel
    public func readAllTravel(completion: @escaping ([Travel]) -> Void ) {
        model.readAllTravel { data in
            completion(data)
        }
    }
    
    public func observedTravel(travelId:String,completion: @escaping (Travel) -> Void ) {
        model.observedTravel(travelId: travelId) { data in
            completion(data)
        }
    }
    
    // 全てのデータベース観測を停止
    public func stopAllObserved(){
        model.stopAllObserved()
    }
    
}

// MARK: - SignIn/Out Fuction
extension FBDatabaseViewModel {
    // MARK: - SingIn
    /// User新規登録時にDBに情報を格納
    public func registerAllRealmDBWithFirebase(travels:Array<Travel>){
        var childUpdates:[String : Any] = [:]
        for travel in travels{
            let scheduleDictionary = convertTypeVM.convertScheduleToDictionary(schedules: travel.schedules)
            let travelBody:[String : Any] = [
                "name": travel.name,
                "members": Array(travel.members),
                "schedules" : scheduleDictionary,
                "startDate": DisplayDateViewModel().getAllDateDisplayFormatString(travel.startDate),
                "endDate": DisplayDateViewModel().getAllDateDisplayFormatString(travel.endDate),
                "share": "true",
                "readableUserlId": [userInfoVM.signInUserId]
            ]
            childUpdates.updateValue(travelBody, forKey: travel.id.stringValue)
        }
        model.registerAllRealmDBWithFirebase(childUpdates: childUpdates)
    }
}
