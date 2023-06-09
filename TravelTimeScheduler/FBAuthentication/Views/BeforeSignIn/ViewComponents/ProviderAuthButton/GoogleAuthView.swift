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
    private let dbControl = SwitchingDatabaseControlViewModel()
    @ObservedObject var authVM = AuthViewModel.shared

    // MARK: - Flag
    public var isCalledFromUserWithDrawaScreen:Bool = false         // WithdrawalButtonViewから呼び出されているか
    
    var body: some View {
        Button(action: {
            
                if isCalledFromUserWithDrawaScreen == false{
                    // サインイン
                    authVM.credentialGoogleSignIn { result in
                        if result {
                            authVM.resetErrorMsg()
                            // 新規登録時にRealmのデータをFirebaseにコピーする処理
                            UserNewEntryRegistrationFBDatabaseViewModel().register()
                            isActive = true
                        }
                    }
                }else{
                    // 退会
                    authVM.credentialGoogleReAuth{ result in
                        dbControl.deleteFBAllTable()    // 認証済みなら退会の前にUserのデータを削除
                        if result {
                            authVM.withdrawal { result in
                                if result {
                                    isPresentedHalfModal = false
                                    isActive = true
                                }
                            }
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
