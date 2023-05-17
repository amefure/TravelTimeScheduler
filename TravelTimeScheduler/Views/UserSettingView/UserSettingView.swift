//
//  UserSettingView.swift
//  TravelTimeScheduler
//
//  Created by t&a on 2023/04/13.
//

import SwiftUI

struct UserSettingView: View {
    
    // MARK: - ViewModels
    private let signInUserInfoVM = SignInUserInfoViewModel.shared
    
    // MARK: - View
    private let columns = Array(repeating: GridItem(.flexible()), count: 3)
    
    var body: some View {
        
        VStack {
            
            Spacer()
            
            // MARK: - Image
            SectionImageView(image: "Relaxation")
            
            // MARK: - User Card
            if AuthViewModel.shared.getCurrentUser() != nil {
                UserInfoView()
            }
            
            // MARK: - Panels
            LazyVGrid(columns: columns,spacing: 20) {
                
                if AuthViewModel.shared.getCurrentUser() != nil {
                    UserinfoEditView()
                }else{
                    UserNameEntryView()
                }
                
                UserSignUpView()
                   
                UserAllTravelDeleteView()
                
                UserReviewLinkView()
                    .disabled(true)
                    .foregroundColor(.gray)
                
                UserShareLinkView()
                    .disabled(true)
                    .foregroundColor(.gray)
               
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
