//
//  WithdrawalButtonView.swift
//  TravelTimeScheduler
//
//  Created by t&a on 2023/04/06.
//

import SwiftUI

struct WithdrawalButtonView: View {
    
    // MARK: - ViewModels
    private let dbControl = SwitchingDatabaseControlViewModel.shared
    private let validationVM = ValidationViewModel()
    @ObservedObject var authVM = AuthViewModel.shared
    
    // MARK: - Navigationプロパティ
    @State var isActive:Bool = false
    @State var isPresentedHalfModal:Bool = false
    @State var isClick:Bool = false
    
    @State var password:String = ""
    
    var body: some View {
        VStack{
            
            List{
                
                // MARK: - ErrorMsg
                Section {
                    ErrorMessageView()
                        .frame(maxWidth:.infinity, alignment: .center)
                }.listRowBackground(Color(hexString: "#f2f2f7")) // リストカラー色
                
                // MARK: - ImageView
                SectionImageView(image: "Withdrawal")
                
                // MARK: - Input (Email Only)
                if SignInUserInfoViewModel().getSignInProvider() == .email {
                    Section("User password?"){
                        SecureInputView(password: $password)
                    }
                }
                
                // MARK: - Button
                Section {
                    if isClick {
                        // 処理中...
                        ProgressView()
                            .tint(.white)
                            .fontWeight(.bold)
                            .buttonStyle(.borderless)
                    }else{
                        
                        Button {
                            isClick = true
                            switch SignInUserInfoViewModel().getSignInProvider() {
                            case .email:
                                
                                if !password.isEmpty{
                                    authVM.credentialEmailWithdrawal(password:password) { result in
                                        if result {
                                            dbControl.deleteAllTable()
                                            isActive = true
                                        }
                                        isClick = false
                                    }
                                }
                            case .apple:
                                isPresentedHalfModal = true
                            case .google:
                                isPresentedHalfModal = true
                            }
                            
                        } label: {
                            Text("このアカウントを削除する")
                                .tint(.white)
                                .fontWeight(.bold)
                            
                        }
                        .disabled(SignInUserInfoViewModel().getSignInProvider() == .email ? !validationVM.validatePassWord(password: password) : false)
                    }
                }.listRowBackground(Color.negative)
                    .frame(maxWidth:.infinity, alignment: .center)
                
                // MARK: - Description
                Section {
                    Text("アカウントを削除するとこれまで記録してきたデータが全て失われます。また友達と共有しているデータも削除される可能性があるので注意してください。")
                        .fontWeight(.bold)
                        .foregroundColor(.gray)
                        .listRowBackground(Color(hexString: "#f2f2f7")) // リストカラー色
                }
                
            }
        }.sheet(isPresented: $isPresentedHalfModal, content: {
            ReAuthProviderView(provider: SignInUserInfoViewModel().getSignInProvider(), isActive: $isActive, isPresentedHalfModal: $isPresentedHalfModal)
                .presentationDetents([.medium])
        })
        .navigationDestination(isPresented: $isActive) {
            TopMainTravelView()
        }.navigationCustomBackground()
            .navigationTitle("User Delete")
    }
}
