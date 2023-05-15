//
//  UserSettingView.swift
//  TravelTimeScheduler
//
//  Created by t&a on 2023/04/13.
//

import SwiftUI

struct UserSettingView: View {
    
    // MARK: - ViewModels
    private let deviceSizeViewModel = DeviceSizeViewModel()
    @ObservedObject var signInUserInfoVM = SignInUserInfoViewModel.shared
    
    // MARK: - View
    private let columns = Array(repeating: GridItem(.flexible()), count: 3)
    
    var body: some View {
        
        VStack {
            
            // MARK: - Image
            BlankTravelView(text: "", imageName: "Relaxation")
            
            // MARK: - User Card
            UserInfoView()
            
            // MARK: - Panels
            LazyVGrid(columns: columns,spacing: 10) {
                
                UserinfoEditView()
                
                SignOutButtonView()
                    .padding()
                    .frame(width:deviceSizeViewModel.deviceWidth/3 - 15,height: deviceSizeViewModel.isSESize ? 90 : 120)
                    .background(.white)
                    .shadowCornerRadius()
                
                UserWithdrawalView()
                
                UserReviewLinkView()
                
                UserShareLinkView()
               
                UserTermsOfServiceLinkView()
                
            }.foregroundColor(Color.thema)
                .padding()
            
            Spacer()
            
            if !deviceSizeViewModel.isSESize {
                // MARK: - AdMob
                AdMobBannerView().frame(height: 60)
            }
        }
            
        .navigationCustomBackground()
        .navigationTitle("User Setting")
        .background(Color(hexString: "#f2f2f7")) // リスト背景色
        .fontWeight(.bold)
    }
}
