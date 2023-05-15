//
//  SignOutButtonView.swift
//  TravelTimeScheduler
//
//  Created by t&a on 2023/04/06.
//

import SwiftUI

struct SignOutButtonView: View {
    
    // MARK: - ViewModels
    @ObservedObject var authVM = AuthViewModel.shared
    
    // MARK: - Navigationプロパティ
    @State var isActive:Bool = false
    
    var body: some View {
        
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
        }.navigationDestination(isPresented: $isActive) {
            LoginAuthView()
        }
        
    }
}

struct SignOutButtonView_Previews: PreviewProvider {
    static var previews: some View {
        SignOutButtonView()
    }
}
