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
    private let authViewModel = AuthViewModel.shared
    
    // MARK: - View
    @State var isPresented:Bool = false
    @State var isPresented2:Bool = false
    @State var searchText:String = ""
    @State var selectTime:String = "all"

    
    var body: some View {
        VStack(spacing:0){
            
            // MARK: - 文字列フィルタリング
            SearchBoxView(searchText: $searchText)
            
            // MARK: - 日付フィルタリング
            PickerTimeView(selectTime: $selectTime)

            /// サインインしているならFirebase DB
            if authViewModel.isSignIn {
                FBRealtimeListTravelView(searchText: $searchText, selectTime: $selectTime)
            }else{
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
        .sheet(isPresented: $isPresented2) {
            ReadingShareTravelView()
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
            if authViewModel.isSignIn {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        isPresented2 = true
                    } label: {
                        Image(systemName: "icloud.and.arrow.down.fill")
                            .foregroundColor(Color.foundation)
                    }
                }
            }
        }
    }
}

