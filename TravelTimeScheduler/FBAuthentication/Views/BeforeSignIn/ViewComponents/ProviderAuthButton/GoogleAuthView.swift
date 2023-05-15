//
//  GoogleAuthView.swift
//  TravelTimeScheduler
//
//  Created by t&a on 2023/03/31.
//

import SwiftUI
import FirebaseCore
import FirebaseAuth
import GoogleSignIn

struct GoogleAuthButtonView: View {
    
    // MARK: - Navigationプロパティ
    @Binding var isActive:Bool
    @Binding var isPresentedHalfModal:Bool
    
    // MARK: - ViewModels
    @ObservedObject var authVM = AuthViewModel.shared

    // MARK: - Flag
    public var isCalledFromUserWithDrawaScreen:Bool = false         // WithdrawalButtonViewから呼び出されているか
    
    var body: some View {
        Button(action: {
            
                if isCalledFromUserWithDrawaScreen == false{
                    authVM.credentialGoogleSignIn { result in
                        if result {
                            authVM.resetErrorMsg()
                            isActive = true
                        }
                    }
                }else{
                    authVM.credentialGoogleWithdrawal { result in
                        if result {
                            isPresentedHalfModal = false
                            isActive = true
                        }
                    }
                }
            
            
        }, label: {
            Text("Sign in with Google")
        }).frame(width:200,height: 40)
            .background(Color.thema)
            .tint(.white)
            .shadowCornerRadius()
            .padding(.bottom,5)
    }
}
