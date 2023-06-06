//
//  AppleAuthView.swift
//  TravelTimeScheduler
//
//  Created by t&a on 2023/03/31.
//

import SwiftUI
import AuthenticationServices
import FirebaseAuth


struct AppleAuthButtonView: View {
    
    // MARK: - ViewModels
    private let dbControl = SwitchingDatabaseControlViewModel.shared
    @ObservedObject var authVM = AuthViewModel.shared
    
    // MARK: - Navigationプロパティ
    @Binding var isActive:Bool
    // MARK: - Navigationプロパティ
    @Binding var isPresentedHalfModal:Bool
    
    // MARK: - Flag
    public var isCalledFromUserWithDrawaScreen:Bool = false         // WithdrawalButtonViewから呼び出されているか
    
    // MARK: - Appleボタン　ボタンタイトル表示用
    private var displayButtonTitle:SignInWithAppleButton.Label{
        if isCalledFromUserWithDrawaScreen == false {
            return .signIn
        }else{
            return .continue
        }
    }
    
    var body: some View {
        
        
        SignInWithAppleButton(displayButtonTitle) { request in
           
            // MARK: - Request
            request.requestedScopes = [.email,.fullName]
            request.nonce = authVM.getHashAndSetCurrentNonce()
            
        } onCompletion: { result in
            
            guard let credential = authVM.switchAuthResult(result: result) else{
                return
            }
            // MARK: - 以下ボタンアクション分岐
            
                
                if isCalledFromUserWithDrawaScreen == false {
                    // MARK: - ログイン
                    authVM.credentialAppleSignIn(credential: credential) { result in
                        authVM.resetErrorMsg()
                        // 新規登録時にRealmのデータをFirebaseにコピーする処理
                        UserNewEntryRegistrationFBDatabaseViewModel().register()
                        isActive = true
                    }
                }else{
                    // MARK: - 退会
                    authVM.withdrawal { result in
                        if result {
                            dbControl.deleteFBAllTable() // 全データリセット
                            isPresentedHalfModal = false
                            isActive = true
                        }
                    }
                }
                
        }.frame(width: 200, height: 40)
            .signInWithAppleButtonStyle(.black)
    }
}
