//
//  UserWithdrawalView.swift
//  TravelTimeScheduler
//
//  Created by t&a on 2023/05/03.
//

import SwiftUI

struct UserWithdrawalView: View {
    
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
        }.userPanelsShape()
        .navigationDestination(isPresented: $isPresented) {
            WithdrawalButtonView() // 画面遷移させるためNavigation
        }
    }
}
