//
//  UserInfoView.swift
//  TravelTimeScheduler
//
//  Created by t&a on 2023/04/28.
//

import SwiftUI
import RealmSwift

struct UserInfoView: View {
    // MARK: - ViewModels
    private let deviceSizeViewModel = DeviceSizeViewModel()
    private var signInUserInfoVM = SignInUserInfoViewModel.shared
    @ObservedResults(Travel.self) var allTravelRelam
    
    @State var active = false // User情報が更新された時に画面を再描画する
    // MARK: - View
    private let columns = [GridItem(.fixed(100)),GridItem(.fixed(DeviceSizeViewModel().isSESize ? 120 : 180))]
    
    var body: some View {
        Group{
            if AuthViewModel.shared.isSignIn {
                LazyVGrid(columns: columns){
                    Group{
                        Text("User Name")
                            .font(.caption)
                        
                        Text(signInUserInfoVM.signInUserName)
                            .foregroundColor(Color.thema)
                            
                    }
                    
                    Group{
                        Text("SignIn Provider")
                            .font(.caption)
                        Text(signInUserInfoVM.signInUserProvider)
                            .foregroundColor(Color.thema)
                    }
                    
                    Group{
                        Text("旅行数")
                            .font(.caption)
                        Text("\(allTravelRelam.count)個")
                            .foregroundColor(Color.thema)
                    }
                    
                    
                    Group{
                        Text("SignIn Email")
                            .font(.caption)
                        Text(signInUserInfoVM.signInUserEmail)
                            .foregroundColor(Color.thema)
                            .lineLimit(1)
                    }
                }.id(active) // User情報が更新された時に画面を再描画する
            }else{
                Text("サインインすると\n友達と旅行記録(タイムスケジュール)を\n共有できるようになります。")
                    .font(.caption)
            }
        }.padding(10)
            .foregroundColor(.gray)
            .frame(width: deviceSizeViewModel.deviceWidth - 50)
            .fontWeight(.bold)
            .background(.white)
            .overlay(
                RoundedRectangle(cornerRadius:5)
                    .stroke(Color.gray,lineWidth: 2)
            )
            .shadowCornerRadius()
            .onAppear{
                active.toggle() // User情報が更新された時に画面を再描画する
            }
    }
}
