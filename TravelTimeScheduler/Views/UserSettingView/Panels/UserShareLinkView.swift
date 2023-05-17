//
//  UserShareLinkView.swift
//  TravelTimeScheduler
//
//  Created by t&a on 2023/05/03.
//

import SwiftUI

struct UserShareLinkView: View {
    
    // MARK: - ViewModels
    private let shareLinkViewModel = ShareLinkViewModel()
    
    var body: some View {
        Button(action: {
            shareLinkViewModel.shareApp(shareText: "旅Timeで旅行のタイムスケジュールを共有しよう！", shareLink: "https://apps.apple.com/jp/app/%E3%81%B5%E3%82%8B%E3%83%AD%E3%82%B0/")
        }, label: {
            VStack{
                Image(systemName: "square.and.arrow.up")
                    .font(.system(size: 40))
                    .frame(height: 40)
                Text("Share App")
            }
        }).userPanelsShape()
    }
}
