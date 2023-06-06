//
//  BlankTravelView.swift
//  TravelTimeScheduler
//
//  Created by t&a on 2023/05/09.
//

import SwiftUI

struct BlankTravelView: View {
    
    // MARK: - ViewModels
    private let deviceSizeVM = DeviceSizeViewModel()
    
    // MARK: - Parameters
    public let text:String
    public let imageName:String
    
    var body: some View {
        VStack{
            Spacer()
            
            Text(text)
                .frame(width: deviceSizeVM.deviceWidth)
                .fontWeight(.bold)
                .foregroundColor(.gray)
            
            Image(imageName)
                .resizable()
                .frame(width: deviceSizeVM.deviceWidth - 100  ,height: deviceSizeVM.deviceWidth / 1.9)
            
            Spacer()
        }.background(Color.list)
    }
}
