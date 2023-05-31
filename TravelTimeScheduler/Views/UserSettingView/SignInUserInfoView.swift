//
//  SignInUserView.swift
//  TravelTimeScheduler
//
//  Created by t&a on 2023/05/18.
//

import SwiftUI

struct SignInUserInfoView: View {
    // MARK: - ViewModels
    @ObservedObject var authVM = AuthViewModel.shared
    private let dbControl = SwitchingDatabaseControlViewModel.shared
    // MARK: - Navigationプロパティ
    @State var isActive:Bool = false
    
    var body: some View {
        List{
            
            // MARK: - ImageView
            SectionImageView(image: "UserInfo")
            
            // MARK: - Input
            Section("Sign Out") {
                Button {
                    dbControl.stopAllObserved()
                    authVM.signOut { result in
                        if result {
                            isActive = true
                        }
                    }
                } label: {
                    VStack{
                        Image(systemName: "figure.walk")
                            .font(.system(size: 40))
                        Text("SignOut")
                    }
                }.listRowBackground(Color.thema)
                    .frame(maxWidth:.infinity, alignment: .center)
                    .foregroundColor(Color.foundation)
            }
            
            
            // MARK: - Button
            Section("Withdrawal") {
                UserWithdrawalView()
                    .listRowBackground(Color.thema)
                    .frame(maxWidth:.infinity, alignment: .center)
                    .foregroundColor(Color.foundation)
            }
            
        }.fontWeight(.bold)
        .navigationCustomBackground()
        .navigationTitle("User Edit")
        .navigationDestination(isPresented: $isActive) {
            TopMainTravelView()
        }
        
    }
}

