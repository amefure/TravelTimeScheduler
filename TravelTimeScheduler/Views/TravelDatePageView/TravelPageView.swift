//
//  TravelDatePageView.swift
//  TravelTimeScheduler
//
//  Created by t&a on 2023/04/17.
//

import SwiftUI
import RealmSwift

struct TravelPageView: View {
    
    // MARK: - ViewModels
    private let realmDataBase = RealmDatabaseViewModel()
    
    // MARK: - Parameters
    public let travel:Travel
    
    // MARK: - View
    @State var selection:Int = 0
    @State var isDeleteMode:Bool = false
    
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
    }
}
