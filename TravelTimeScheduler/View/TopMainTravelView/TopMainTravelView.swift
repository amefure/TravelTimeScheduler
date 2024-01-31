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
        
        ZStack(alignment: .bottomTrailing) {
            
            VStack(spacing:0) {
                // MARK: - フィルタリング
                FilteringContainerView(searchText: $searchText, selectTime: $selectTime)
                
                // MARK: - サインイン→Firebase DB / 未サインイン→Relam DB
                if authVM.isSignIn {
                    FBRealtimeListTravelView(searchText: $searchText, selectTime: $selectTime)
                } else {
                    RealmListTravelView(searchText: $searchText, selectTime: $selectTime)
                }
                
                // MARK: - AdMob
                AdMobBannerView()
                    .frame(height: 60)
            }
            
            // MARK: - Entry Button
            NavigationLink {
                EntryTravelView(travel: nil, parentDismissFunction: {})
            } label: {
                Image(systemName: "plus")
                    .foregroundStyle(.white)
                    .fontWeight(.bold)
                    .frame(width: 55, height: 55)
                    .background(Color.thema)
                    .clipShape(RoundedRectangle(cornerRadius: 55))
                    .shadow(color: .gray, radius: 2, x: 1, y: 1)
            }.offset(x: -30, y: -70)
            
            
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

