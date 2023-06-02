//
//  SignOutButtonView.swift
//  TravelTimeScheduler
//
//  Created by t&a on 2023/04/06.
//

import SwiftUI

struct UserSignUpView: View {
    
    // MARK: - ViewModels
    @ObservedObject var authVM = AuthViewModel.shared
    
    var body: some View {
        NavigationLink {
            if authVM.isSignIn {
                SignInUserInfoView()
            }else{
                NewEntryAuthView()
            }
        } label: {
            VStack{
                Image(systemName: "person.fill.checkmark")
                    .font(.system(size: 40))
                    .frame(height: 40)
                Text(authVM.isSignIn ? "Account" : "Sign Up")
            }
        }.userPanelsShape()
    }
}
