//
//  ReAuthEmailView.swift
//  TravelTimeScheduler
//
//  Created by t&a on 2023/05/16.
//

import SwiftUI

// MARK: - EmailUser用　再認証View
struct ReAuthEmailView: View {
    // MARK: - ViewModels
    private let validationVM = ValidationViewModel()
    @ObservedObject var authVM = AuthViewModel.shared
    
    // MARK: - Navigationプロパティ
    @Binding var isActive:Bool
    @Binding var name:String
    @Binding var email:String
    @Binding var isClick:Bool
    @Binding var isReAuth:Bool
    
    @State var pass:String = ""
    @State var isClick2:Bool = false
    @State var isSuccess:Bool = false
    
    private func validationInput()-> Bool{
        if validationVM.validateEmpty(str: name) && validationVM.validateEmail(email: email) && validationVM.validatePassWord(password: pass) {
            return true
        }
        return false
    }
    
    var body: some View {
        // MARK: - Header
        HeaderTitleView(title: "再認証")
            .frame(width: DeviceSizeViewModel().deviceWidth)
            .padding()
            .background(Color.thema)
        
        Spacer()
        
        List{
            
            // MARK: - ErrorMsg
            Section {
                ErrorMessageView()
                    .frame(maxWidth:.infinity, alignment: .center)
            }.listRowBackground(Color(hexString: "#f2f2f7")) // リストカラー色
            
            // MARK: - Input
            Section("User password?"){
                SecureInputView(password: $pass)
            }
            
            // MARK: - Button
            Section {
                if isClick2 {
                    // 処理中...
                    ProgressView()
                        .tint(.white)
                        .fontWeight(.bold)
                        .buttonStyle(.borderless)
                }else{
                    Button {
                        isClick2 = true
                        authVM.editUserName(name: name) { result in
                            if result {
                                authVM.updateEmail(email: email, password: pass) { result in
                                    if result {
                                        isSuccess = true
                                        isReAuth = false
                                    }else{
                                        isClick2 = false
                                    }
                                }
                            }else{
                                isClick2 = false
                            }
                        }
                        
                    } label: {
                        Text("再認証")
                            .tint(.white)
                            .fontWeight(.bold)
                        
                    }.disabled(!validationInput())
                }
            }.listRowBackground(Color.thema)
                .frame(maxWidth:.infinity, alignment: .center)
            
        }.onDisappear{
            isClick = false
            if isSuccess {
                isActive = true
            }
        }
    }
}