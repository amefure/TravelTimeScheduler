//
//  RowTravelView.swift
//  TravelTimeScheduler
//
//  Created by t&a on 2023/04/26.
//

import SwiftUI

struct RowTravelView: View {
    
    // MARK: - ViewModels
    private let displayDateVM = DateFormatManager()
    
    // MARK: - Parameters
    let travel: Travel
    
    var body: some View {
        NavigationLink {
            TravelPageView(travel: travel)
        } label: {
            VStack(alignment: .leading) {
                Image("Walking_outside")
                    .resizable()
                    .scaledToFit()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: DeviceSizeManager.deviceWidth - 40, height: 100)
                    .clipped()
                
                Text(travel.name)
                    .lineLimit(1)
                    .font(.system(size: 18))
                    .padding(.bottom, 8)
                
                HStack{
                    Text(displayDateVM.getJapanDateDisplayFormatString(travel.startDate))
                    Text("〜")
                    Text(displayDateVM.getJapanDateDisplayFormatString(travel.endDate))
                }.font(.system(size: 12))
                
            }
        }.padding([.horizontal, .bottom])
            .frame(width: DeviceSizeManager.deviceWidth - 20)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .foregroundStyle(.gray)
            .fontWeight(.bold)
            .background(.white)
            .compositingGroup()
            .shadow(color: .gray, radius: 2, x: 1, y: 1)
    }
}
