//
//  ErrorMessageView.swift
//  TravelTimeScheduler
//
//  Created by t&a on 2023/03/31.
//

import SwiftUI

struct ErrorMessageView: View {
    
    // MARK: - ViewModels
    @ObservedObject var authVM = AuthViewModel.shared
    
    var body: some View {
        if authVM.errMessage != "" {
            Text("・\(authVM.errMessage)")
                .padding(5)
                .foregroundColor(.white)
                .background(Color(red: 1, green: 0, blue: 0, opacity: 0.5))
                .cornerRadius(5)
                .onDisappear{
                    authVM.errMessage = ""
                }
        }
    }
}

