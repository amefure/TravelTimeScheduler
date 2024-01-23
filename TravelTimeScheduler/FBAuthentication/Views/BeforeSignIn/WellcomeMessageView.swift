//
//  MsgHeaderView.swift
//  TravelTimeScheduler
//
//  Created by t&a on 2023/05/08.
//

import SwiftUI

struct WellcomeMessageView: View {
    
    var text:String
    
    
    var body: some View {
        Group {
            
            Text("旅Time")
                .foregroundColor(.gray)
                .font(.system(size: DeviceSizeManager.isSESize ? 20 : 30 ,design:.monospaced))
                .padding(.bottom, DeviceSizeManager.isSESize ? 10 : 30)
                
            Text(text)
                .padding(.bottom, DeviceSizeManager.isSESize ? 5 : 15)
                .padding(.horizontal)
                .font(.system(size: DeviceSizeManager.isSESize ? 17 : 20,design: .monospaced))
            
        }.foregroundColor(Color(hexString: "#333333"))
            .fontWeight(.bold)
    }
}
