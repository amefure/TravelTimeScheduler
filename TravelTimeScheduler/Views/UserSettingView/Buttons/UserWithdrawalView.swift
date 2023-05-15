//
//  UserWithdrawalView.swift
//  TravelTimeScheduler
//
//  Created by t&a on 2023/05/03.
//

import SwiftUI

struct UserWithdrawalView: View {
    
    // MARK: - ViewModels
    private let deviceSizeViewModel = DeviceSizeViewModel()
    // MARK: - View
    @State var isPresented:Bool = false
    
    var body: some View {
        Button {
            isPresented = true
        } label: {
            VStack{
                Image(systemName: "arrow.right.to.line.compact")
                    .font(.system(size: 40))
                    .frame(height: 40)
                Text("退会...")
            }
        }
        .padding()
        .frame(width:deviceSizeViewModel.deviceWidth/3 - 15,height: deviceSizeViewModel.isSESize ? 90 : 120)
        .background(.white)
        .shadowCornerRadius()
        .navigationDestination(isPresented: $isPresented) {
            WithdrawalButtonView() // 画面遷移させるためNavigation
        }
    }
}
