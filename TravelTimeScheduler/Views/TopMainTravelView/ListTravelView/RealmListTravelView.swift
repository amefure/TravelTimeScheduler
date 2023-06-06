//
//  RealmListTravelView.swift
//  TravelTimeScheduler
//
//  Created by t&a on 2023/05/18.
//

import SwiftUI
import RealmSwift
struct RealmListTravelView: View {
    
    // MARK: - ViewModels
    private let dbControl = SwitchingDatabaseControlViewModel.shared // migrationのため必要
    private let displayDateVM = DisplayDateViewModel()
    
    // MARK: - Database
    @ObservedResults(Travel.self,sortDescriptor:SortDescriptor(keyPath: "startDate", ascending: false)) var allTravelRelam
    
    // MARK: - View
    @Binding var searchText:String
    @Binding var selectTime:String
    
    // MARK: - フィルタリング
    private var filteringResults:Results<Travel> {
        if searchText.isEmpty && selectTime == "all"{
            // フィルタリングなし
            return allTravelRelam
        }else if searchText.isEmpty && selectTime != "all" {
            // 年数のみ
            let array = displayDateVM.getYearStringDateArray(selectTime)
            return allTravelRelam.filter("startDate between {%@, %@}", array[0],array[1])
        }else if searchText.isEmpty == false &&  selectTime != "all" {
            // 検索値＆年数
            let array = displayDateVM.getYearStringDateArray(selectTime)
            return allTravelRelam.filter("name contains %@", searchText).filter("startDate between {%@, %@}", array[0],array[1])
        }else{
            // 検索値のみ
            return allTravelRelam.filter("name contains %@", searchText)
        }
    }
    
    // MARK: - TravelListView
    var body: some View {
        if searchText.isEmpty && filteringResults.count == 0 {
            // 履歴未登録時のビュー
            BlankTravelView(text: "旅行を登録してね♪", imageName: "Traveling")
        }else if !searchText.isEmpty && filteringResults.count == 0 {
            // 検索時にマッチする履歴がない場合のビュー
            BlankTravelView(text: "「\(searchText)」にマッチする\n旅行履歴はありませんでした。", imageName: "Walking_outside")
        }else{
            // 履歴リスト表示ビュー
            List(filteringResults){ travel in
                RowTravelView(travel: travel)
            }.listStyle(GroupedListStyle())
        }
    }
}
