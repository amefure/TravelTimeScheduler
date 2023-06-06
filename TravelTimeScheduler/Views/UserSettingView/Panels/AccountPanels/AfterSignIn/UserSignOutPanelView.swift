//
//  UserSignOutPanelView.swift
//  TravelTimeScheduler
//
//  Created by t&a on 2023/06/03.
//

import SwiftUI

struct UserSignOutPanelView: View {
    // MARK: - ViewModels
    @ObservedObject var authVM = AuthViewModel.shared
    private let dbControl = SwitchingDatabaseControlViewModel()
    // MARK: - Navigationプロパティ
    @State var isActive:Bool = false
    @State var isPresented:Bool = false
    
    var body: some View {
        Button {
            isPresented = true
        } label: {
            VStack{
                Image(systemName: "figure.walk")
                    .font(.system(size: 40))
                Text("SignOut")
            }
        }.navigationDestination(isPresented: $isActive) {
                TopMainTravelView()
            }.alert("サインアウトしますか？", isPresented: $isPresented) {
                Button {
                    
                } label: {
                    Text("キャンセル")
                }
                Button {
                    dbControl.stopAllObserved()
                    authVM.signOut { result in
                        if result {
                            isActive = true
                        }
                    }
                } label: {
                    Text("サインアウト")
                }
            }
    }
}
