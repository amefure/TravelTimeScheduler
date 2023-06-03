//
//  UserWithdrawalView.swift
//  TravelTimeScheduler
//
//  Created by t&a on 2023/05/03.
//

import SwiftUI

struct UserWithdrawalPanelView: View {
    
    var body: some View {
        NavigationLink {
            WithdrawalButtonView()
        } label: {
            VStack{
                Image(systemName: "arrow.right.to.line.compact")
                    .font(.system(size: 40))
                    .frame(height: 40)
                Text("User Delete")
            }
        }.userPanelsShape()
    }
}
