//
//  EntryUserNameView.swift
//  TravelTimeScheduler
//
//  Created by t&a on 2023/05/18.
//

import SwiftUI

struct EntryUserNameView: View {
    
    // MARK: - ViewModels
    private let validationVM = ValidationViewModel()
    private let signInUserInfoVM = SignInUserInfoViewModel.shared
    
    // MARK: - Navigationプロパティ
    @State var isActive:Bool = false
    @State var name:String = ""

    var body: some View {
        VStack{
            
            List{
                
                // MARK: - ImageView
                SectionImageView(image: "UserInfo")
                
                // MARK: - Input
                Section("User Name") {
                    TextField("UserName", text: $name)
                }
                
                
                // MARK: - Button
                Button {
                    signInUserInfoVM.signInUserName = name
                    isActive = true
                } label: {
                    Text("更新")
                        .tint(.white)
                        .fontWeight(.bold)
                }.disabled(!validationVM.validateEmpty(str:name))
                    .listRowBackground(Color.thema)
                    .frame(maxWidth:.infinity, alignment: .center)
            }
            
        }.alert("ユーザー名を更新しました", isPresented: $isActive) {
            
        }
        .navigationCustomBackground()
        .navigationTitle("User Edit")
        .onAppear {
            name = signInUserInfoVM.signInUserName
        }

    }
}
