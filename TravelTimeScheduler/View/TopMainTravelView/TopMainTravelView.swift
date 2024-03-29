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
    private let authVM = AuthViewModel.shared
    
    // MARK: - View
    @State var isEntryTravelPresented:Bool = false
    
    // MARK: - FilteringView
    @State var searchText:String = ""
    @State var selectTime:String = "all"
    
    
    var body: some View {
        VStack(spacing:0){
            
            // MARK: - フィルタリング
            FilteringContainerView(searchText: $searchText, selectTime: $selectTime)
            
            // MARK: - サインイン→Firebase DB / 未サインイン→Relam DB
            if authVM.isSignIn {
                FBRealtimeListTravelView(searchText: $searchText, selectTime: $selectTime)
            }else{
                RealmListTravelView(searchText: $searchText, selectTime: $selectTime)
            }
            
            // MARK: - Entry Button
            NavigationLink {
                EntryTravelView(travel:nil, parentDismissFunction: {})
            } label: {
                Text("旅行登録")
            }.frame(width:  DeviceSizeManager.isSESize ? 80 : 100 ,height: DeviceSizeManager.isSESize ? 45 : 60)
                .background(Color.foundation)
                .foregroundColor(Color.thema)
                .shadowCornerRadius()
                .padding()
                .fontWeight(.bold)
            
            // MARK: - AdMob
            AdMobBannerView()
                .frame(height: 60)
            
        }.ignoresSafeArea(.keyboard)
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .background(Color.thema)
            .toolbar {
                // MARK: - Header
                ToolbarItem(placement: .principal) {
                    HeaderTitleView(title: "旅Time")
                        .padding(.top)
                }
                
                // MARK: - RightButton
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: {
                        UserSettingView()
                    }, label: {
                        Image(systemName: "gearshape.fill")
                            .foregroundColor(Color.foundation)
                    })
                }
                // MARK: - LeftButton
                if authVM.isSignIn {
                    ToolbarItem(placement: .navigationBarLeading) {
                        NavigationLink {
                            ReadingShareTravelView()
                        } label: {
                            Image(systemName: "icloud.and.arrow.down.fill")
                                .foregroundColor(Color.foundation)
                        }
                    }
                }
            }
    }
}

