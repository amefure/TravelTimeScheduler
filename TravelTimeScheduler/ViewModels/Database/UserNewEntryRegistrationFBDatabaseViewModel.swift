//
//  UserNewEntryRegistrationFBDatabaseViewModel.swift
//  TravelTimeScheduler
//
//  Created by t&a on 2023/06/04.
//

import UIKit
import RealmSwift

class UserNewEntryRegistrationFBDatabaseViewModel {
    
    // FB RealtimeDatabase User
    private let dbControl = SwitchingDatabaseControlViewModel.shared
    private let allTravelFirebase = FBDatabaseTravelListViewModel.shared
    private let userInfoVM = SignInUserInfoViewModel.shared
    
    @ObservedResults(Travel.self,sortDescriptor:SortDescriptor(keyPath: "startDate", ascending: false)) var allTravelRelam
    
    public func register(){
        // サインインした際にはクラウド上にUser情報とRelamDB情報を格納しておく
        dbControl.createUser(userId: userInfoVM.signInUserId, name: userInfoVM.signInUserName)
        dbControl.registerAllRealmDBWithFirebase(travels: allTravelRelam)
        dbControl.deleteRealmAllTable()
    }

}
