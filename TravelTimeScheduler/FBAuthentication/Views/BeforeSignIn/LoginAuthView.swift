//
//  LoginAuthView.swift
//  TravelTimeScheduler
//
//  Created by t&a on 2023/03/31.
//

import SwiftUI

struct LoginAuthView: View {

    // MARK: - Inputプロパティ
    @State  var email:String = ""
    @State  var password:String = ""
    
    // MARK: - Navigationプロパティ
    @State var isActive:Bool = false
    
    var body: some View {
        VStack {
            
            // MARK: - エラーメッセージ
            ErrorMessageView()
            
            // MARK: - メッセージ
            WellcomeMessageView(text: "おかえりなさい！")
            
            // MARK: - InputBox
            AuthInputBoxView(isLogin: true, name: Binding.constant(""), email: $email, password: $password)
            
            // MARK: - パスワードリセット画面遷移ボタン
            HStack{
                Spacer()
                NavigationLink(destination: PasswordResetView(), label: {
                    Text("パスワードをお忘れですか？")
                        .font(.system(size: 15))
                        .foregroundColor(.thema)
                }).padding(.trailing)
            }
            
            // MARK: - ログインボタン
            EmailAuthButtonView(isActive: $isActive, name: nil, email: email, password: password)
                .padding(5)

            Text("または").padding(5)
            
            // MARK: - Googleアカウントログイン
            GoogleAuthButtonView(isActive: $isActive,isPresentedHalfModal:Binding.constant(false))
            
            // MARK: - Apple IDログイン
            AppleAuthButtonView(isActive: $isActive,isPresentedHalfModal:Binding.constant(false) )
            // MARK: - 未登録遷移ボタン
            HStack{
                Spacer()
                NavigationLink(destination: NewEntryAuthView(), label: {
                    Text("未登録の方はこちら")
                        .font(.system(size: 15))
                        .foregroundColor(.thema)
                }).padding(.trailing)
            }
            
        }.navigationBarHidden(true)
            .navigationDestination(isPresented: $isActive) {
                TopMainTravelView()
            }
    }
}
