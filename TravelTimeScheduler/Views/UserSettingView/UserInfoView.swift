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
    private let signInUserInfoVM = SignInUserInfoViewModel.shared
    @ObservedResults(Travel.self) var allTravelRelam
    
    // MARK: - View
    private let columns = [GridItem(.fixed(100)),GridItem(.fixed(DeviceSizeViewModel().isSESize ? 120 : 180))]
    
    var body: some View {
        
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
        }
        .padding()
            .foregroundColor(.gray)
            .frame(width: deviceSizeViewModel.deviceWidth - 90)
            .fontWeight(.bold)
            .background(.white)
            .overlay(
                RoundedRectangle(cornerRadius:5)
                    .stroke(Color.gray,lineWidth: 2)
            )
            .shadowCornerRadius()
    }
}
