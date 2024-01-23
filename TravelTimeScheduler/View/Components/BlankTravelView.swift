//
//  BlankTravelView.swift
//  TravelTimeScheduler
//
//  Created by t&a on 2023/05/09.
//

import SwiftUI

struct BlankTravelView: View {
    
    
    // MARK: - Parameters
    public let text:String
    public let imageName:String
    
    var body: some View {
        VStack{
            Spacer()
            
            Text(text)
                .frame(width: DeviceSizeManager.deviceWidth)
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
