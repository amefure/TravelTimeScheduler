//
//  WithdrawalButtonView.swift
//  TravelTimeScheduler
//
//  Created by t&a on 2023/04/06.
//

import SwiftUI

struct WithdrawalButtonView: View {
    
    // MARK: - ViewModels
    private let dbControl = SwitchingDatabaseControlViewModel()
    private let validationVM = ValidationUtility()
    @ObservedObject var authVM = AuthViewModel.shared
    private let userInfoVM = SignInUserInfoViewModel()
    
    // MARK: - Navigationプロパティ
    @State var isActive:Bool = false
    @State var isPresentedHalfModal:Bool = false
    @State var isClick:Bool = false
    
    @State var password:String = ""
    
    var body: some View {
        VStack(spacing: 0){
            
            // MARK: - ErrorMsg
            ErrorMessageView()
                .frame(maxWidth:.infinity, alignment: .center)
                .padding(.top,10)
                        
            List{

                // MARK: - ImageView
                SectionImageView(image: "Withdrawal")
                
                // MARK: - Input (Email Only)
                if userInfoVM.getSignInProvider() == .email {
                    Section("User password?"){
                        SecureInputView(password: $password)
                    }
                }
                
                // MARK: - Button
                Section(content: {
                    ProgressButtonStack(isClick: $isClick) {
                        
                        Button {
                            isClick = true
                            dbControl.stopAllObserved()
                            switch userInfoVM.getSignInProvider() {
                            case .email:
                                
                                if !password.isEmpty{
                                    authVM.credentialEmailReAuthUser(password:password) { result in
                                        if result {
                                            dbControl.deleteFBAllTable()  // 認証済みなら退会の前にUserのデータを削除
                                            authVM.withdrawal { result in
                                                if result {
                                                    isActive = true
                                                }
                                            }
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
                        .disabled(userInfoVM.getSignInProvider() == .email ? !validationVM.validatePassWord(password: password) : false)
                    }
                }, footer: {
                    Text("・アカウントを削除すると記録してきたデータのうち誰とも共有していないデータが全て失われます。")
                        .fontWeight(.bold)
                        .foregroundColor(.gray)
                        .listRowBackground(Color(hexString: "#f2f2f7")) // リストカラー色
                }).listRowBackground(Color.negative)
                    .frame(maxWidth:.infinity, alignment: .center)
                
                
            }
        }.background(Color.list)
            .sheet(isPresented: $isPresentedHalfModal, content: {
                ReAuthProviderView(provider: userInfoVM.getSignInProvider(), isActive: $isActive, isPresentedHalfModal: $isPresentedHalfModal)
                    .presentationDetents([.medium])
            })
            .navigationDestination(isPresented: $isActive) {
                TopMainTravelView()
            }.navigationCustomBackground()
            .navigationTitle("User Delete")
    }
}
