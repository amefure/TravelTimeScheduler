//
//  UserSettingView.swift
//  TravelTimeScheduler
//
//  Created by t&a on 2023/04/13.
//

import SwiftUI

struct UserSettingView: View {
    
    // MARK: - ViewModels
    @ObservedObject var signInUserInfoVM = SignInUserInfoViewModel.shared
    
    // MARK: - View
    private let columns = Array(repeating: GridItem(.flexible()), count: 3)
    
    var body: some View {
        
        VStack {
            
            // MARK: - Image
            SectionImageView(image: "Relaxation")
            
            // MARK: - User Card
            UserInfoView()
            
            // MARK: - Panels
            LazyVGrid(columns: columns,spacing: 10) {
                
                UserinfoEditView()
                
                UserSignOutView()
                   
                UserWithdrawalView()
                
                UserReviewLinkView()
                
                UserShareLinkView()
               
                UserTermsOfServiceLinkView()
                
            }.foregroundColor(Color.thema)
                .padding()
            
            Spacer()
            
            if !DeviceSizeViewModel().isSESize {
                // MARK: - AdMob
                AdMobBannerView().frame(height: 60)
            }
        }    
        .navigationCustomBackground()
        .navigationTitle("User Setting")
        .background(Color.list)
        .fontWeight(.bold)
    }
}
