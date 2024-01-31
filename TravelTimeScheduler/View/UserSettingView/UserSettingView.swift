//
//  UserSettingView.swift
//  TravelTimeScheduler
//
//  Created by t&a on 2023/04/13.
//

import SwiftUI

struct UserSettingView: View {
    
    private let authVM = AuthViewModel.shared
    
    // MARK: - View
    private let columns = Array(repeating: GridItem(.flexible()), count: 3)
    
    var body: some View {
        
        VStack {
            
            Spacer()
            
            // MARK: - Image
            SectionImageView(image: "Relaxation")
            
            // MARK: - User Card
            UserInfoCardView()
            
            // MARK: - Panels
            LazyVGrid(columns: columns,spacing: 20) {
                
                if authVM.isSignIn {
                    UserinfoEditLinkPanelView()
                } else {
                    UserNameEntryLinkPanelView()
                }
                
                if authVM.isSignIn  {
                    UserSignOutPanelView()
                } else {
                    UserSignUpLinkPanelView()
                }
                
                if !authVM.isSignIn  {
                    UserAllTravelDeletePanelView()
                }
                
                if authVM.isSignIn  {
                    UserWithdrawalLinkPanelView()
                }
                
                UserReviewLinkPanelView()
                
                UserShareLinkPanelView()
               
                UserTermsOfServiceLinkPanelView()
                
                
            }.foregroundColor(Color.thema)
                .padding()
            
            Spacer()
            
            if !DeviceSizeManager.isSESize {
                // MARK: - AdMob
                AdMobBannerView().frame(height: 60)
            }
        }    
        .navigationCustomBackground()
        .navigationTitle("User Setting")
        .background(Color.list)
        .fontWeight(.bold)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing, content: {
                NavigationLink {
                    HowToUseTheAppView()
                } label: {
                    Image(systemName: "questionmark.app")
                }
            })
        }
    }
}
