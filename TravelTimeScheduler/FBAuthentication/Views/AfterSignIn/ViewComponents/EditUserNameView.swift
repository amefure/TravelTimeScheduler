//
//  EditUserNameView.swift
//  TravelTimeScheduler
//
//  Created by t&a on 2023/04/12.
//

import SwiftUI

struct EditUserNameView: View {
    
    // MARK: - ViewModels
    private let deviceSize = DeviceSizeViewModel()
    @ObservedObject var authVM = AuthViewModel.shared
    @ObservedObject var signInUserInfoVM = SignInUserInfoViewModel.shared
    
    // MARK: - Navigationプロパティ
    @State var isActive:Bool = false
    @State var name:String = ""
    @State var isClick:Bool = false
    
    var body: some View {
        VStack{
            
            List{
                Section {
                    Image("UserInfo")
                        .resizable()
                        .frame(width: deviceSize.deviceWidth - 100  ,height: deviceSize.deviceWidth / 1.9)
                        .background(Color(hexString: "#f2f2f7")) // リストカラー色
                }.listRowBackground(Color(hexString: "#f2f2f7")) // リストカラー色
                
                Section("User Name") {
                    TextField("UserName", text: $name)
                }
                
//                Section("Travel Setting") {
//
//                }
                
                Group{
                    // MARK: - ボタン
                    if isClick {
                        // 処理中...
                        ProgressView()
                            .tint(.white)
                            .fontWeight(.bold)
                            .buttonStyle(.borderless)
                    }else{
                        Button {
                             isClick = true
                            authVM.editUserName(name: name) { result in
                                isClick = false
                                isActive = true
                            }
                        } label: {
                            Text("更新")
                                .tint(.white)
                                .fontWeight(.bold)

                        }
                    }
                    
                }.listRowBackground(Color.thema)
                    .frame(maxWidth:.infinity, alignment: .center)
            }
            
        }.alert("更新しました", isPresented: $isActive) {
            
        }
        .navigationCustomBackground()
        .navigationTitle("User Edit")
        .onAppear {
            name = signInUserInfoVM.signInUserName
        }
    }
}
