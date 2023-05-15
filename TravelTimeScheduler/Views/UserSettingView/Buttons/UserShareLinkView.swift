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
    private let deviceSizeViewModel = DeviceSizeViewModel()
    
    var body: some View {
        Button(action: {
            shareLinkViewModel.shareApp(shareText: "旅Timeで旅行のタイムスケジュールを共有しよう！", shareLink: "https://tech.amefure.com/")
        }, label: {
            VStack{
                Image(systemName: "square.and.arrow.up")
                    .font(.system(size: 40))
                    .frame(height: 40)
                Text("Appをシェア")
                    .font(.caption)
            }
        })
            .padding()
            .frame(width:deviceSizeViewModel.deviceWidth/3 - 15,height: deviceSizeViewModel.isSESize ? 90 : 120)
            .background(.white)
            .shadowCornerRadius()
    }
}
