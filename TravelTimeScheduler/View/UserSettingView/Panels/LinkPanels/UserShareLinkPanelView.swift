//
//  UserShareLinkView.swift
//  TravelTimeScheduler
//
//  Created by t&a on 2023/05/03.
//

import SwiftUI

struct UserShareLinkPanelView: View {
    
    // MARK: - ViewModels
    private let shareLinkVM = UserSettingViewModel()
    
    var body: some View {
        Button(action: {
            shareLinkVM.shareApp(shareText: "旅Timeで旅行のタイムスケジュールを共有しよう！", shareLink: "https://apps.apple.com/jp/app/%E6%97%85time/id6449208868")
        }, label: {
            VStack{
                Image(systemName: "square.and.arrow.up")
                    .font(.system(size: 40))
                    .frame(height: 40)
                Text("Appを勧める")
            }
        })
    }
}
