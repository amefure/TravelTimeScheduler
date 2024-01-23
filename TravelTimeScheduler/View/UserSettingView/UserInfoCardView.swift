//
//  UserInfoView.swift
//  TravelTimeScheduler
//
//  Created by t&a on 2023/04/28.
//

import SwiftUI

/// User情報を表示するカード
struct UserInfoCardView: View {
    
    // MARK: - ViewModels
    private var userInfoVM = SignInUserInfoViewModel()
    private let allTravelFirebase = FBDatabaseTravelListViewModel.shared
    @State var active = false // User情報が更新された時に画面を再描画する
    // MARK: - View
    private let columns = [GridItem(.fixed(100)),GridItem(.fixed(DeviceSizeManager.isSESize ? 160 : 180))]
    
    var body: some View {
        Group{
            if AuthViewModel.shared.isSignIn {
                LazyVGrid(columns: columns){
                    Group{
                        Text("ユーザー名")
                            .font(.caption)
                        Text(userInfoVM.signInUserName)
                            .foregroundColor(Color.thema)
                            .lineLimit(1)
                    }
                    
                    Group{
                        Text("SignIn Provider")
                            .font(.caption)
                        Text(userInfoVM.signInUserProvider)
                            .foregroundColor(Color.thema)
                    }
                    
                    Group{
                        Text("旅行数")
                            .font(.caption)
                        Text("\(allTravelFirebase.travels.filter({$0.readableUserlId.contains(userInfoVM.signInUserId)}).count)個")
                            .foregroundColor(Color.thema)
                    }
                    
                    Group{
                        Text("Email")
                            .font(.caption)
                        Text(userInfoVM.signInUserEmail)
                            .foregroundColor(Color.thema)
                            .lineLimit(1)
                    }
                }.id(active) // User情報が更新された時に画面を再描画する
            }else{
                HStack{
                    Image(systemName: "person.icloud")
                        .padding(.trailing,10)
                        .font(.title)
                    Text("ユーザー登録をすると\n友達と旅行記録(タイムスケジュール)を\n共有できるようになります。")
                        .font(.caption)
                }
                
            }
        }.floatingCard()
            .onAppear{
                active.toggle() // User情報が更新された時に画面を再描画する
            }
    }
}
