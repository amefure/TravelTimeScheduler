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
                .offset(y:-30)
            
            Image(imageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 300  ,height: 100)
            
            Spacer()
        }.background(Color.list)
    }
}
