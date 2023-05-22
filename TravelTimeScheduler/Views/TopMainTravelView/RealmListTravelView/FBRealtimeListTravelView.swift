//
//  FBRealtimeListTravelView.swift
//  TravelTimeScheduler
//
//  Created by t&a on 2023/05/18.
//

import SwiftUI

struct FBRealtimeListTravelView: View {
    
    private let displayDateViewModel = DisplayDateViewModel()
    
    // MARK: - View
    @Binding var searchText:String
    @Binding var selectTime:String
    
    @ObservedObject var databaseModel = FBDatabaseViewModel.shared
    
    private var filteringResults:Array<Travel> {
        if searchText.isEmpty && selectTime == "all"{
            // フィルタリングなし
            return databaseModel.Travels
        }else if searchText.isEmpty && selectTime != "all" {
            // 年数のみ
            let array = displayDateViewModel.getYearStringDateArray(selectTime)
            return databaseModel.Travels // .filter("startDate between {%@, %@}", array[0],array[1])
        }else if searchText.isEmpty == false &&  selectTime != "all" {
            // 検索値＆年数
            let array = displayDateViewModel.getYearStringDateArray(selectTime)
            return databaseModel.Travels // .filter("name contains %@", searchText).filter("startDate between {%@, %@}", array[0],array[1])
        }else{
            // 検索値のみ
            return databaseModel.Travels // .filter("name contains %@", searchText)
        }
    }
    
    
    var body: some View {
        // MARK: - TravelListView
        Group{
            if searchText.isEmpty && databaseModel.Travels.count == 0 {
                // 履歴未登録時のビュー
                BlankTravelView(text: "旅行を登録してね♪", imageName: "Traveling")
            }else if !searchText.isEmpty && databaseModel.Travels.count == 0 {
                // 検索時にマッチする履歴がない場合のビュー
                BlankTravelView(text: "「\(searchText)」にマッチする\n旅行履歴はありませんでした。", imageName: "Walking_outside")
            }else{
                // 履歴リスト表示ビュー
                FBListTravelView(filteringResults: filteringResults)
            }
        }.onAppear{
            databaseModel.readAllTravel()
        }
    }
}
