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
    private let userInfoVM = SignInUserInfoViewModel()
    private let dbControl = SwitchingDatabaseControlViewModel.shared
    
    // MARK: - Bindingプロパティ
    @Binding var isActive:Bool
    @Binding var name:String
    @Binding var email:String
    @Binding var isClick:Bool
    @Binding var isReAuth:Bool
    
    // MARK: - Viewプロパティ
    @State var pass:String = ""
    @State var isProgressDisplay:Bool = false
    @State var isUpdateSuccess:Bool = false
    
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
                ProgressButtonStack(isClick: $isProgressDisplay) {
                    Button {
                        isProgressDisplay = true
                        authVM.editUserName(name: name) { result in
                            if result {
                                dbControl.createUser(userId: userInfoVM.signInUserId, name: name)
                                authVM.updateEmail(email: email, password: pass) { result in
                                    if result {
                                        isUpdateSuccess = true
                                        isReAuth = false
                                    }else{
                                        isProgressDisplay = false
                                    }
                                }
                            }else{
                                isProgressDisplay = false
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
            if isUpdateSuccess {
                isActive = true
            }
        }
    }
}
