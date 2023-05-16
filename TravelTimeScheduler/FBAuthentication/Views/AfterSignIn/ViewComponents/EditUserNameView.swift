//
//  EditUserNameView.swift
//  TravelTimeScheduler
//
//  Created by t&a on 2023/04/12.
//

import SwiftUI

struct EditUserNameView: View {
    
    // MARK: - ViewModels
    private let validationVM = ValidationViewModel()
    @ObservedObject var authVM = AuthViewModel.shared
    @ObservedObject var signInUserInfoVM = SignInUserInfoViewModel.shared
    
    // MARK: - Navigationプロパティ
    @State var isActive:Bool = false
    @State var name:String = ""
    @State var email:String = ""
    @State var isClick:Bool = false
    @State var isEmailEdit:Bool = false
    @State var isReAuth:Bool = false
    @FocusState var isFocus:Bool
    
    private func validationInput()-> Bool{
        if isEmailEdit {
            if validationVM.validateEmpty(str: name) && validationVM.validateEmail(email: email) {
                return true
            }
        }else{
            if validationVM.validateEmpty(str: name) {
                return true
            }
        }
        return false
    }
    
    var body: some View {
        VStack{
            
            List{
                
                // MARK: - ImageView
                SectionImageView(image: "UserInfo")
                
                // MARK: - Input
                Section("User Name") {
                    TextField("UserName", text: $name)
                }
                
                // MARK: - Input2 (email Only)
                if signInUserInfoVM.signInUserProvider == "email" {
                    Section("Mail Address") {
                        HStack{
                            if isEmailEdit {
                                TextField("Email", text: $email)
                                    .focused($isFocus)
                            }else{
                                Text(email)
                                Spacer()
                                Button {
                                    isEmailEdit = true
                                    isFocus = true
                                } label: {
                                    Text("編集")
                                }.buttonStyle(.borderless)
                                    .foregroundColor(.thema)
                            }
                        }
                    }
                }
                
                // MARK: - Button
                Group{
                    if isClick {
                        // 処理中...
                        ProgressView()
                            .tint(.white)
                            .fontWeight(.bold)
                            .buttonStyle(.borderless)
                    }else{
                        Button {
                            isClick = true
                            if isEmailEdit {
                                isReAuth = true
                            }else{
                                authVM.editUserName(name: name) { result in
                                    isClick = false
                                    isActive = true
                                }
                            }
                        } label: {
                            Text("更新")
                                .tint(.white)
                                .fontWeight(.bold)
                        }.disabled(!validationInput())
                    }
                    
                }.listRowBackground(Color.thema)
                    .frame(maxWidth:.infinity, alignment: .center)
            }
            
        }.alert("ユーザー情報を更新しました", isPresented: $isActive) {
            
        }
        .navigationCustomBackground()
        .navigationTitle("User Edit")
        .onAppear {
            name = signInUserInfoVM.signInUserName
            email = signInUserInfoVM.signInUserEmail
        }
        .onDisappear {
            isEmailEdit = false
        }
        .sheet(isPresented: $isReAuth) {
            ReAuthEmailView(isActive: $isActive, name: $name, email: $email, isClick: $isClick, isReAuth: $isReAuth)
                .presentationDetents([.medium])
        }
    }
}
