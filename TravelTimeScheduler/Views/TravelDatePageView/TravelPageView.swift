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
    @State var selection:Int = 0
    @State var isDeleteMode:Bool = false
    @State var isSharePresented = false
    
    var body: some View {
        VStack(spacing:0){
            
            // MARK: - 日付タブピッカー
            ScrollPeriodTabPickerView(travel: travel, selection: $selection)
            
            // MARK: - 日付ごとのスケジュール表示ビュー
            ScheduleTabMainView(travel: travel,selection: $selection, isDeleteMode: $isDeleteMode)
            
            // MARK: - 日付ごとのコントロールパネル(旅行編集/追加/削除)
            ScheduleControlPanelView(travel: travel, isDeleteMode: $isDeleteMode, selection: $selection)
            
            // MARK: - Admob
            AdMobBannerView().frame(height: 60)
            
        }.navigationTitle(travel.name)
            .toolbar {
                if authVM.isSignIn{
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            isSharePresented = true
                        }) {
                            VStack{
                                Image(systemName: "cloud.fill")
                                Text("共有")
                                    .font(.caption)
                            }
                        }
                    }
                }
            }
            .navigationDestination(isPresented: $isSharePresented) {
                ShareTravelView(travel: travel)
            }
            .toolbarTitleMenu {
                if travel.members.first == "" {
                    // countは0でも1になる(Blankがあるため)
                    Text("No Member")
                }else{
                    ForEach(travel.members,id: \.self) { member in
                        Text(member)
                    }
                }
            }
            .background(Color.thema)
            .navigationCustomBackground()
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
