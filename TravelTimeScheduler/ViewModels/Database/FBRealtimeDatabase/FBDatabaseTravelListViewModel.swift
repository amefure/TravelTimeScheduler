//
//  FBDatabaseTravelListViewModel.swift
//  TravelTimeScheduler
//
//  Created by t&a on 2023/05/22.
//

import UIKit

// MARK: - Firebaseから抽出したリアルタイムの情報を保持するクラス
class FBDatabaseTravelListViewModel:ObservableObject{
    
    /// サインインUserが読み取り可能なTravelID配列
    @Published var userReadableTravelIds:[String] = []
    
    /// DBから抽出したTravel情報
    @Published var Travels:[Travel] = []
    
    // MARK: シングルトン
    static let shared:FBDatabaseTravelListViewModel = FBDatabaseTravelListViewModel()
    
    
    public func resetData(){
        Travels = []
        userReadableTravelIds = []
    }
}
