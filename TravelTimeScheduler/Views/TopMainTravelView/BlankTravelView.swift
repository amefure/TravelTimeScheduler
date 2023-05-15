//
//  BlankTravelView.swift
//  TravelTimeScheduler
//
//  Created by t&a on 2023/05/09.
//

import SwiftUI

struct BlankTravelView: View {
    
    // MARK: - ViewModels
    private let deviceSizeViewModel = DeviceSizeViewModel()
    
    // MARK: - Parameters
    public let text:String
    public let imageName:String
    
    var body: some View {
        VStack{
            Spacer()
            
            Text(text)
                .frame(width: deviceSizeViewModel.deviceWidth)
                .fontWeight(.bold)
                .foregroundColor(.gray)
            
            Image(imageName)
                .resizable()
                .frame(width: deviceSizeViewModel.deviceWidth - 100  ,height: deviceSizeViewModel.deviceWidth / 1.9)
            
            Spacer()
        }.background(Color(hexString: "#f2f2f7")) // リストカラー色
    }
}
