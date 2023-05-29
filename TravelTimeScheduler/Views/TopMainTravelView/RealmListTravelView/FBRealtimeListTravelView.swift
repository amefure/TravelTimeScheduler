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
    
    @ObservedObject var allTravelFirebase = FBDatabaseTravelListViewModel.shared
    private let dbControl = SwitchingDatabaseControlViewModel.shared
    
    private var filteringResults:Array<Travel> {
        
        // 全Travel情報の中からサインインUserが読み取り可能な情報のみにフィルタリング
        let result = allTravelFirebase.Travels.filter({ allTravelFirebase.userReadableTravelIds.contains($0.id.stringValue)})
        
        if searchText.isEmpty && selectTime == "all" {
            // フィルタリングなし
            return result
        }else if searchText.isEmpty && selectTime != "all"{
            // 年数のみ
            let startAndEndDate = displayDateViewModel.getYearStringDateArray(selectTime)
            return result.filter({ (startAndEndDate[0]...startAndEndDate[1]).contains($0.startDate)})
        }else if searchText.isEmpty == false &&  selectTime != "all"  {
            // 検索値＆年数
            let startAndEndDate = displayDateViewModel.getYearStringDateArray(selectTime)
            return result.filter({$0.name.contains(searchText)}).filter({ (startAndEndDate[0]...startAndEndDate[1]).contains($0.startDate)})
        }else{
            // 検索値のみ
            return result.filter({$0.name.contains(searchText)})
        }
    }
    
    
    var body: some View {
        // MARK: - TravelListView
        Group{
            if searchText.isEmpty && filteringResults.count == 0 {
                // 履歴未登録時のビュー
                BlankTravelView(text: "旅行を登録してね♪", imageName: "Traveling")
            }else if !searchText.isEmpty && filteringResults.count == 0 {
                // 検索時にマッチする履歴がない場合のビュー
                BlankTravelView(text: "「\(searchText)」にマッチする\n旅行履歴はありませんでした。", imageName: "Walking_outside")
            }else{
                // 履歴リスト表示ビュー
                FBListTravelView(filteringResults: filteringResults)
            }
        }.onAppear{
            dbControl.readAllTravel { data in
                allTravelFirebase.Travels = data
            }
            dbControl.observeUserReadableTravelIds(userId: SignInUserInfoViewModel.shared.signInUserId) { data in
                allTravelFirebase.userReadableTravelIds = data
            }
        }
    }
}
