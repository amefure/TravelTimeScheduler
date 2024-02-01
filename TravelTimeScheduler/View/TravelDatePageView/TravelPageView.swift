//
//  TravelDatePageView.swift
//  TravelTimeScheduler
//
//  Created by t&a on 2023/04/17.
//

import SwiftUI
import RealmSwift

struct TravelPageView: View {
    
    // MARK: - Parameters
    public let travel:Travel
    
    private let authVM = AuthViewModel.shared
    @ObservedObject var allTravelFirebase = FBDatabaseTravelListViewModel.shared
    private let dbControl = SwitchingDatabaseControlViewModel()
    
    // MARK: - View
    @State private var selection:Int = 0
    @State private var isDeleteMode:Bool = false
    @State private var isSharePresented = false
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack(spacing: 0) {
            
            HeaderView(
                title: travel.name,
                leadingIcon: "chevron.backward",
                trailingIcon: authVM.isSignIn ? "cloud.fill": "",
                leadingAction: {
                    dismiss()
                }, trailingAction: {
                    isSharePresented = true
                },
                isShowMenu: true,
                members: Array(travel.members)
            )
            
            // MARK: - 日付タブピッカー
            ScrollPeriodTabPickerView(travel: travel, selection: $selection)
            
            // MARK: - 日付ごとのスケジュール表示ビュー
            ScheduleTabMainView(travel: travel,selection: $selection, isDeleteMode: $isDeleteMode)
            
            // MARK: - 日付ごとのコントロールパネル(旅行編集/追加/削除)
            ScheduleControlPanelView(travel: travel, isDeleteMode: $isDeleteMode, selection: $selection)
            
            // MARK: - Admob
            AdMobBannerView().frame(height: 60)
            
        }.navigationBarBackButtonHidden(true)
            .navigationDestination(isPresented: $isSharePresented) {
                ShareTravelView(travel: travel)
            }
            .background(Color.thema)
            .onAppear{
                if authVM.isSignIn{
                    dbControl.observedTravel(travelId: travel.id.stringValue) { data in
                        // アクティブになったページの変更を観測
                        // 変更があった場合は同じ要素のインデックスに再格納する
                        if let index =  allTravelFirebase.travels.firstIndex(where: {$0.id == data.id}) {
                            allTravelFirebase.travels[index] = data
                        }
                    }
                }
            }
    }
}
