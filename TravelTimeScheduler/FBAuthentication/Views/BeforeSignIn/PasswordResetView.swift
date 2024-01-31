//
//  PasswordResetView.swift
//  TravelTimeScheduler
//
//  Created by t&a on 2023/03/31.
//

import SwiftUI
import FirebaseAuth

struct PasswordResetView: View {
    
    // MARK: - ViewModels
    @ObservedObject var authVM = AuthViewModel.shared
    private let validationVM = ValidationUtility()
    
    // MARK: - Inputプロパティ
    @State var email:String = ""
    
    // MARK: - Inputプロパティ
    @State var wasSent:Bool = false
        
    var body: some View {
        VStack{
            
            if wasSent{
                Text("メールアドレス宛に再設定用のメールを送信しました。")
            }
            
            // MARK: - エラーメッセージ
            ErrorMessageView()
            
            // MARK: - メッセージ
            WellcomeMessageView(text: "パスワードを忘れてしまった場合は登録しているメールアドレスを入力してください。\n入力されたメールアドレスに再設定用のメールが届きますので記載されているURLから再設定を行ってください。")
            
            TextField("メールアドレス", text: $email).padding().textFieldStyle(.roundedBorder)
            
            Button(action: {
                if validationVM.validateEmail(email: email) {
                    authVM.resetPassWord(email: email) { result in
                        wasSent = result
                    }
                }
            }, label: {
                Text("メール送信")
            }).frame(width:80)
                .padding()
                .background(Color.thema)
                .tint(.white)
                .shadowCornerRadius()
                .padding()
        }.onAppear {
            authVM.resetErrorMsg()
        }
        .navigationCustomBackground()
            .navigationTitle("Password Reset")
    }
}
