//
//  FBRealtimeListTravelView.swift
//  TravelTimeScheduler
//
//  Created by t&a on 2023/05/18.
//

import SwiftUI

struct FBRealtimeListTravelView: View {
    
    // MARK: - ViewModels
    private let displayDateVM = DateFormatManager()
    private let userInfoVM = SignInUserInfoViewModel()
    private let dbControl = SwitchingDatabaseControlViewModel()
    
    // MARK: - Database
    @ObservedObject var allTravelFirebase = FBDatabaseTravelListViewModel.shared
    
    // MARK: - View
    @Binding var searchText:String
    @Binding var selectTime:String
    
    // MARK: - フィルタリング
    private var filteringResults:Array<Travel> {
        
        // 全Travel情報の中からサインインUserが読み取り可能な情報のみにフィルタリング
        let result = allTravelFirebase.travels.filter({$0.readableUserlId.contains(userInfoVM.signInUserId)})
        
        if searchText.isEmpty && selectTime == "all" {
            // フィルタリングなし
            return result
        } else if searchText.isEmpty && selectTime != "all" {
            // 年数のみ
            let startAndEndDate = displayDateVM.getYearStringDateArray(selectTime)
            return result.filter({ (startAndEndDate[0]...startAndEndDate[1]).contains($0.startDate)})
        } else if searchText.isEmpty == false &&  selectTime != "all" {
            // 検索値＆年数
            let startAndEndDate = displayDateVM.getYearStringDateArray(selectTime)
            return result.filter({$0.name.contains(searchText)}).filter({ (startAndEndDate[0]...startAndEndDate[1]).contains($0.startDate)})
        } else {
            // 検索値のみ
            return result.filter({$0.name.contains(searchText)})
        }
    }
    
    // MARK: - TravelListView
    var body: some View {
        Group {
            if searchText.isEmpty && filteringResults.count == 0 {
                // 履歴未登録時のビュー
                BlankTravelView(text: "旅行を登録してね♪", imageName: "Traveling")
            }else if !searchText.isEmpty && filteringResults.count == 0 {
                // 検索時にマッチする履歴がない場合のビュー
                BlankTravelView(text: "「\(searchText)」にマッチする\n旅行履歴はありませんでした。", imageName: "Walking_outside")
            }else{
                
                ScrollView {
                    // 履歴リスト表示ビュー
                    ForEach(filteringResults) { travel in
                        RowTravelView(travel: travel)
                    }
                    
                    Spacer()
                }.padding()
                    .background(Color.list)
               
            }
        }.onAppear{
            dbControl.readAllTravel { data in
                allTravelFirebase.travels = data
            }
        }
    }
}
