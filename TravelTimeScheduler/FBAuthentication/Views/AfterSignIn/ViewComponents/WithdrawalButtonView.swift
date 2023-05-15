//
//  WithdrawalButtonView.swift
//  TravelTimeScheduler
//
//  Created by t&a on 2023/04/06.
//

import SwiftUI

struct WithdrawalButtonView: View {
    
    // MARK: - ViewModels
    private let deviceSize = DeviceSizeViewModel()
    @ObservedObject var authVM = AuthViewModel.shared
    
    // MARK: - Navigationプロパティ
    @State var isActive:Bool = false
    @State var isPresentedHalfModal:Bool = false
    
    @State var password:String = ""
    
    var body: some View {
        VStack{
            
            List{
                Section {
                    Image("Withdrawal")
                        .resizable()
                        .frame(width: deviceSize.deviceWidth - 100  ,height: deviceSize.deviceWidth / 1.9)
                        .background(Color(hexString: "#f2f2f7")) // リストカラー色
                   
                }.listRowBackground(Color(hexString: "#f2f2f7")) // リストカラー色
                    .listRowSeparator(.hidden)
                
                if SignInUserInfoViewModel().getSignInProvider() == .email {
                    // MARK: - Email
                    Section("User password?"){
                        SecureInputView(password: $password)
                    }
                    
                }
                Section {
                    Button {
                        
                        switch SignInUserInfoViewModel().getSignInProvider() {
                        case .email:
                            
                            if !password.isEmpty{
                                authVM.credentialEmailWithdrawal(password:password) { result in
                                    if result {
                                        isActive = true
                                    }
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
                        
                    }.frame(maxWidth:.infinity, alignment: .center)
                        .listRowBackground(Color.negative)
                }
                Section {
                    Text("アカウントを削除するとこれまで記録してきたデータが全て失われます。また友達と共有しているデータも削除される可能性があるので注意してください。")
                        .fontWeight(.bold)
                        .foregroundColor(.gray)
                        .listRowBackground(Color(hexString: "#f2f2f7")) // リストカラー色
                }
    
            }
        }.sheet(isPresented: $isPresentedHalfModal, content: {
           ReAuthView(provider: SignInUserInfoViewModel().getSignInProvider(), isActive: $isActive, isPresentedHalfModal: $isPresentedHalfModal)
        })
        .navigationDestination(isPresented: $isActive) {
            LoginAuthView()
        }.navigationCustomBackground()
            .navigationTitle("User Delete")
    }
}
