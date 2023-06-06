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
    private let signInUserInfoVM = SignInUserInfoViewModel.shared
    
    // MARK: - Generic Type
    typealias RecordId = String
    typealias DBMembersCollection = Array<String>
    typealias DBScheduleCollection = [String : [String : String]]//Array<Schedule>
    
    
    public func createTravel(travelName: String, members: Array<String>, startDate: Date, endDate: Date) {
        let childUpdates:[String : Any] = [
            "name": travelName,
            "members": members,
            "startDate": DisplayDateViewModel().getAllDateDisplayFormatString(startDate),
            "endDate": DisplayDateViewModel().getAllDateDisplayFormatString(endDate),
            "share": "true"
        ]
        let id:String = convertTypeVM.generateObjectIdString()
        model.updateTravelReadableUserId(userId: signInUserInfoVM.signInUserId, travelId: id)
        model.entryTravel(id:id ,childUpdates: childUpdates)
    }
    

    
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
    
    public func deleteTravel(id: String) {
        model.deleteTravel(id: id)
    }
    
    // MARK: - Schedule
    public func addSchedule(travel:Travel,schedule:Schedule){
        model.addSchedule(travelId: travel.id.stringValue, currentSchedules: travel.schedules, addSchedule: schedule)
    }
    
    public func updateSchedule(travelId: String, scheduleId: String, dateTime: Date, content: String, memo: String, type: ScheduleType, tranceportation: Tranceportation?) {
        let sc = Schedule()
        sc.id = convertTypeVM.convertStringToObjectId(strID: scheduleId)
        sc.content = content
        sc.dateTime = dateTime
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
        model.deleteAllTable(userId: signInUserInfoVM.signInUserId)
    }
    
}

extension FBDatabaseViewModel {
    // MARK: - User
    /// User新規登録時にDBに情報を格納
    public func createUser(userId:String,name:String){
        model.createUser(userId:userId, name: name)
    }
    /// Travel共有時にUser内にtravelIdを格納
    public func updateTravelReadableUserId(userId:String,travelId:String){
        model.updateTravelReadableUserId(userId:userId,travelId:travelId)
    }
    
    // MARK: - Travel
    // Entry
    public func entryTravel(travel:Travel){
        let scheduleDictionary = convertTypeVM.convertScheduleToDictionary(schedules: travel.schedules)
        let childUpdates:[String : Any] = [
            "name": travel.name,
            "members": Array(travel.members),
            "schedules" : scheduleDictionary,
            "startDate": DisplayDateViewModel().getAllDateDisplayFormatString(travel.startDate),
            "endDate": DisplayDateViewModel().getAllDateDisplayFormatString(travel.endDate),
            "share": "true"
        ]
        model.entryTravel(id:travel.id.stringValue,childUpdates: childUpdates)
    }
    
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
                "readableUserlId": [signInUserInfoVM.signInUserId]
            ]
            childUpdates.updateValue(travelBody, forKey: travel.id.stringValue)
        }
        model.registerAllRealmDBWithFirebase(childUpdates: childUpdates)
    }
}
