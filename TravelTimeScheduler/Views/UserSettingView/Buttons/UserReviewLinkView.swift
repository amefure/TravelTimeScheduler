//
//  UserReviewLinkView.swift
//  TravelTimeScheduler
//
//  Created by t&a on 2023/05/03.
//

import SwiftUI

struct UserReviewLinkView: View {
    
    // MARK: - ViewModels
    private let deviceSizeViewModel = DeviceSizeViewModel()
    
    var body: some View {
        Link(destination:URL.init(string: "https://apps.apple.com/jp/app/%E3%81%B5%E3%82%8B%E3%83%AD%E3%82%B0/id1644963031?action=write-review")!,
          label: {
            VStack{
                Image(systemName:"hand.thumbsup")
                    .font(.system(size: 40))
                    .frame(height: 40)
                Text("Review")
            }
        }).padding()
            .frame(width:deviceSizeViewModel.deviceWidth/3 - 15,height: deviceSizeViewModel.isSESize ? 90 : 120)
            .background(.white)
            .shadowCornerRadius()
    }
}
