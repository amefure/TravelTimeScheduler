//
//  SignInUserView.swift
//  TravelTimeScheduler
//
//  Created by t&a on 2023/05/18.
//

import SwiftUI

struct SignInUserView: View {
    // MARK: - ViewModels
    @ObservedObject var authVM = AuthViewModel.shared
    
    // MARK: - Navigationプロパティ
    @State var isActive:Bool = false
    
    var body: some View {
        List{
            
            // MARK: - ImageView
            SectionImageView(image: "UserInfo")
            
            // MARK: - Input
            Section("Sign Out") {
                Button {
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
            
        }
        .navigationCustomBackground()
        .navigationTitle("User Edit")
        .navigationDestination(isPresented: $isActive) {
            TopMainTravelView()
        }
        
    }
}

