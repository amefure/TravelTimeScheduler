//
//  RowTravelView.swift
//  TravelTimeScheduler
//
//  Created by t&a on 2023/04/26.
//

import SwiftUI

struct RowTravelView: View {
    
    // MARK: - ViewModels
    private let displayDate = DisplayDateViewModel()
    
    // MARK: - Parameters
    let travel:Travel
    
    var body: some View {
        HStack{
            Image(systemName: "mappin.circle.fill")
                .foregroundColor(Color.thema)
                .font(.system(size: DeviceSizeViewModel().isSESize ? 35 : 40))
                .opacity(0.8)
            
            VStack{
                NavigationLink {
                    TravelPageView(travel: travel)
                } label: {
                    Text(travel.name)
                        .lineLimit(1)
                }
                
                HStack{
                    Text(displayDate.getJapanDateDisplayFormatString(travel.startDate))
                    Text("〜")
                    Text(displayDate.getJapanDateDisplayFormatString(travel.endDate))
                }.font(.system(size: 12))
                
            }.fontWeight(.bold)
        }
    }
}
