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
    
    @State private var isShowHowToUse = false
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        
        VStack {
            
            HeaderView(
                title: "User Setting",
                leadingIcon: "chevron.backward",
                trailingIcon: "questionmark.app",
                leadingAction: {
                    dismiss()
                },
                trailingAction: {
                    isShowHowToUse = true
                })
            
            
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
        }.background(Color.list)
            .navigationBarBackButtonHidden(true)
            .fontWeight(.bold)
            .navigationDestination(isPresented: $isShowHowToUse, destination: {
                HowToUseTheAppView()
            })
    }
}
