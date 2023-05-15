//
//  TopMainTravelView.swift
//  TravelTimeScheduler
//
//  Created by t&a on 2023/05/09.
//

import SwiftUI
import RealmSwift

struct TopMainTravelView: View {
    
    // MARK: - ViewModels
    private let realmDataBase = RealmDatabaseViewModel()
    private let displayDateViewModel = DisplayDateViewModel()
    private let deviceSizeViewModel = DeviceSizeViewModel()
    
    @ObservedResults(Travel.self,sortDescriptor:SortDescriptor(keyPath: "startDate", ascending: false)) var allTravelRelam
    
    // MARK: - View
    @State var isPresented:Bool = false
    @State var searchText:String = ""
    @State var selectTime:String = "all"
    
    private var filteringResults:Results<Travel> {
        if searchText.isEmpty && selectTime == "all"{
            // フィルタリングなし
            return allTravelRelam
        }else if searchText.isEmpty && selectTime != "all" {
            // 年数のみ
            let array = displayDateViewModel.getYearStringDateArray(selectTime)
            return allTravelRelam.filter("startDate between {%@, %@}", array[0],array[1])
        }else if searchText.isEmpty == false &&  selectTime != "all" {
            // 検索値＆年数
            let array = displayDateViewModel.getYearStringDateArray(selectTime)
            return allTravelRelam.filter("name contains %@", searchText).filter("startDate between {%@, %@}", array[0],array[1])
        }else{
            // 検索値のみ
            return allTravelRelam.filter("name contains %@", searchText)
        }
    }
    
    var body: some View {
        VStack(spacing:0){
            
            // MARK: - 文字列フィルタリング
            SearchBoxView(searchText: $searchText)
            
            // MARK: - 日付フィルタリング
            PickerTimeView(selectTime: $selectTime)
            
            // MARK: - TravelListView
            if searchText.isEmpty && filteringResults.count == 0 {
                // 履歴未登録時のビュー
                BlankTravelView(text: "旅行を登録してね♪", imageName: "Traveling")
            }else if !searchText.isEmpty && filteringResults.count == 0 {
                // 検索時にマッチする履歴がない場合のビュー
                BlankTravelView(text: "「\(searchText)」にマッチする\n旅行履歴はありませんでした。", imageName: "Walking_outside")
            }else{
                // 履歴リスト表示ビュー
                ListTravelView(filteringResults: filteringResults)
            }
            
            HStack{
                Button(action: {
                    isPresented = true
                }, label: {
                    Text("旅行登録")
                }).frame(width:  deviceSizeViewModel.isSESize ? 80 : 100 ,height: deviceSizeViewModel.isSESize ? 45 : 60)
                    .background(Color.foundation)
                    .foregroundColor(Color.thema)
                    .shadowCornerRadius()
            }.padding()
                .fontWeight(.bold)
            
            AdMobBannerView().frame(height: 60)
            
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .background(Color.thema)
        .sheet(isPresented: $isPresented) {
            EntryTravelView(travel:nil,parentDismissFunction: {})
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                HeaderTitleView(title: "旅Time")
                    .padding(.top)
            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink(destination: {
                    UserSettingView()
                }, label: {
                    Image(systemName: "gearshape.fill")
                        .foregroundColor(Color.foundation)
                })
            }
            
        }
    }
}

