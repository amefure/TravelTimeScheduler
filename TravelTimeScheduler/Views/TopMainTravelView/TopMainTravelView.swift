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
    private let displayDateViewModel = DisplayDateViewModel()
    private let deviceSizeViewModel = DeviceSizeViewModel()
    
    // MARK: - ObservedViewModels
    @ObservedObject var currentDBStatus = CurrentDatabaseStatusViewModel.shared
    
    // MARK: - View
    @State var isPresented:Bool = false
    @State var searchText:String = ""
    @State var selectTime:String = "all"

    
    var body: some View {
        VStack(spacing:0){
            
            // MARK: - 文字列フィルタリング
            SearchBoxView(searchText: $searchText)
            
            // MARK: - 日付フィルタリング
            PickerTimeView(selectTime: $selectTime)
            
            /// DBどちらのタブがアクティブになっているかで表示するリストを変更
            if currentDBStatus.isFB {
                FBRealtimeListTravelView(searchText: $searchText, selectTime: $selectTime)
            }else{
                // MARK: - RealmTravelListView
                RealmListTravelView(searchText: $searchText, selectTime: $selectTime)
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
            
        }.ignoresSafeArea(.keyboard, edges: .bottom)
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
            // サインインしていないなら非表示
            if AuthViewModel.shared.getCurrentUser() != nil {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        currentDBStatus.isFB.toggle()
                    } label: {
                        Text(currentDBStatus.isFB ? "Not Share" : "Share")
                    }
                }
            }
        }
    }
}

