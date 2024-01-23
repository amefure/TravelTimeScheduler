//
//  EntryAuthView.swift
//  TravelTimeScheduler
//
//  Created by t&a on 2023/03/31.
//

import SwiftUI

struct NewEntryAuthView: View {
    
    // MARK: - ViewModels
    @ObservedObject var authVM = AuthViewModel.shared
    
    // MARK: - Inputプロパティ
    @State  var name:String = ""
    @State  var email:String = ""
    @State  var password:String = ""
    
    // MARK: - Navigationプロパティ
    @State  var isActive:Bool = false
    
    var body: some View {
        VStack {
            
            // MARK: - エラーメッセージ
            ErrorMessageView()
            
            // MARK: - メッセージ
            WellcomeMessageView(text:"ようこそ\n旅行の記録を始めよう！")
            
            // MARK: - InputBox
            AuthInputBoxView(isLogin: false, name: $name, email: $email, password: $password)

            
            // MARK: - ログインボタン
            EmailAuthButtonView(isActive: $isActive, name: name, email: email, password: password)
            
            Text("または").padding(5)
            
            // MARK: - Googleアカウントログイン
            GoogleAuthButtonView(isActive: $isActive,isPresentedHalfModal:Binding.constant(false))
            
            // MARK: - Apple IDログイン
            AppleAuthButtonView(isActive: $isActive,isPresentedHalfModal:Binding.constant(false))
            
            // MARK: - 登録済みボタン
            HStack{
                Spacer()
                NavigationLink(destination: LoginAuthView(), label: {
                    Text("登録済みの方はこちら")
                        .font(.system(size: 15))
                        .foregroundColor(.thema)
                }).padding(.trailing)
            }
            
        }.onAppear {
            authVM.resetErrorMsg()
        }.navigationDestination(isPresented: $isActive) {
            TopMainTravelView()
        }.navigationCustomBackground()
            .navigationTitle("New Entry")
    }
}
