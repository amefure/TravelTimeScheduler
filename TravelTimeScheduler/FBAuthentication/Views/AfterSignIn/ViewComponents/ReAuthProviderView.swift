//
//  ReAuthView.swift
//  TravelTimeScheduler
//
//  Created by t&a on 2023/05/15.
//

import SwiftUI

// MARK: - Apple/Google User用　再認証View
struct ReAuthProviderView: View {
    // MARK: - ViewModels
    private let deviceSize = DeviceSizeViewModel()
    
    public let provider:AuthProviderModel
    
    // MARK: - Navigationプロパティ
    @Binding var isActive:Bool
    @Binding var isPresentedHalfModal:Bool
    
    var body: some View {
        VStack{
            HeaderTitleView(title: "再認証")
                .frame(width: deviceSize.deviceWidth)
                .padding()
                .background(Color.thema)
            
            Spacer()
            
            Text("アカウントを削除するには再認証してください")
            
            if provider == .apple{
                AppleAuthButtonView(isActive: $isActive,isPresentedHalfModal: $isPresentedHalfModal, isCalledFromUserWithDrawaScreen: true)
            }else if provider == .google{
                GoogleAuthButtonView(isActive: $isActive,isPresentedHalfModal: $isPresentedHalfModal, isCalledFromUserWithDrawaScreen: true)
            }

            Spacer()
        }
    }
}
