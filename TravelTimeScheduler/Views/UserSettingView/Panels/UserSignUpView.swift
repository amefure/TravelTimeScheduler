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
    
    // MARK: - Navigationプロパティ
    @State var isActiveNewEntry:Bool = false
    @State var isActiveSignIn:Bool = false
    
    var body: some View {
        Button {
            if AuthViewModel.shared.isSignIn {
                isActiveSignIn = true
            }else{
                isActiveNewEntry = true
            }
            
        } label: {
            VStack{
                Image(systemName: "person.fill.checkmark")
                    .font(.system(size: 40))
                    .frame(height: 40)
                Text("Sign Up")
            }
        }.userPanelsShape()
            .navigationDestination(isPresented: $isActiveNewEntry) {
                NewEntryAuthView()
            }
            .navigationDestination(isPresented: $isActiveSignIn) {
                SignInUserInfoView()
            }
    }
}
