//
//  UserTermsOfServiceLinkView.swift
//  TravelTimeScheduler
//
//  Created by t&a on 2023/05/03.
//

import SwiftUI

struct UserTermsOfServiceLinkView: View {
    
    // MARK: - ViewModels
    private let deviceSizeViewModel = DeviceSizeViewModel()
    
    var body: some View {
        Link(destination:URL.init(string: "https://tech.amefure.com/app-terms-of-service")!,
          label: {
            VStack{
                Image(systemName:"note.text")
                    .font(.system(size: 40))
                    .frame(height: 40)
                Text("利用規約")
            }
        })
            .padding()
            .frame(width:deviceSizeViewModel.deviceWidth/3 - 15,height: deviceSizeViewModel.isSESize ? 90 : 120)
            .background(.white)
            .shadowCornerRadius()
    }
}
