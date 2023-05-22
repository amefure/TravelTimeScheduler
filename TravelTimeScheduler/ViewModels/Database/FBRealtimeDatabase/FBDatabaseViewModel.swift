//
//  FBDatabaseViewModel.swift
//  TravelTimeScheduler
//
//  Created by t&a on 2023/04/07.
//

import UIKit
import FirebaseDatabase

class FBDatabaseViewModel:ObservableObject{
    /// DBから抽出したTravel情報
    @Published var Travels:[Travel] = []
    
    // MARK: シングルトン
    static let shared:FBDatabaseViewModel = FBDatabaseViewModel()
    
    // MARK: - Models
    private let model = FBDatabaseModel()
    
    // MARK: -  ViewModels
    private let convertTypeVM = ConvertTypeViewModel()
    
}


/// FirebaseDatabaseから抽出したTravel情報
extension FBDatabaseViewModel:CrudDatabaseViewModel{
    
    // MARK: - Generic Type
    typealias RecordId = String
    typealias DBMembersCollection = Array<String>
    typealias DBScheduleCollection = Array<Schedule>
    
    
    internal func createTravel(travelName: String, members: Array<String>, startDate: Date, endDate: Date) {
        
    }
    

    
    func updateTravel(id: String, travelName: String, members: Array<String>, startDate: Date, endDate: Date, schedules: Array<Schedule>) {
        
    }

    func updateShareTravel(travel: Travel, share: Bool) {
        
    }
    
    func deleteTravel(id: String) {
        
    }
    
    // MARK: - Schedule
    func addSchedule(id: String, schedule: Schedule) {
        
    }
    
    func updateSchedule(travelId: String, scheduleId: String, dateTime: Date, content: String, memo: String, type: ScheduleType, tranceportation: Tranceportation?) {
        
    }
    
    func deleteSchedule(travelId: String, scheduleId: String) {
        
    }
    
    // MARK: - All
    func deleteAllTable() {
        
    }
    
}

extension FBDatabaseViewModel {
    // MARK: - User
    /// User新規登録時にDBに情報を格納
    public func createUser(userId:String,name:String){
        model.createUser(userId:userId, name: name)
    }
    
    // MARK: - Travel
    // Entry
    public func entryTravel(id:String,childUpdates:[String : Any]){
        model.entryTravel(id:id,childUpdates: childUpdates)
    }
    
    public func readAllTravel(){
        model.readAllTravel { data in
            self.Travels = data
        }
    }
}
