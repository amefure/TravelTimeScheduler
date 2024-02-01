//
//  RowTravelView.swift
//  TravelTimeScheduler
//
//  Created by t&a on 2023/04/26.
//

import SwiftUI

struct RowTravelView: View {
    
    // MARK: - Utility
    private let dateFormatManager = DateFormatManager()
    
    // MARK: - ViewModels
    private let viewModel = RowTravelViewModel()
    
    // MARK: - Parameters
    let travel: Travel
    // onAppearで格納
    @State private var url: URL?
    
    var body: some View {
        NavigationLink {
            TravelPageView(travel: travel)
        } label: {
            VStack(alignment: .leading) {
                
                if let url = url {
                    AsyncImage(url: url) { image in
                        image
                            .resizable()
                                .scaledToFit()
                                .aspectRatio(contentMode: .fill)
                    } placeholder: {
                        ProgressView()
                    }.frame(width: DeviceSizeManager.deviceWidth - 20, height: 100)
                        .clipped()
                    
                } else {
                    Image("Walking_outside")
                        .resizable()
                        .scaledToFit()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: DeviceSizeManager.deviceWidth - 20, height: 100)
                        .clipped()
                    
                }
               
                Text(travel.name)
                    .lineLimit(1)
                    .font(.system(size: 18))
                    .padding(.bottom, 8)
                    .frame(width: DeviceSizeManager.deviceWidth - 40)
                
                HStack{
                    Text(dateFormatManager.getJapanDateDisplayFormatString(travel.startDate))
                    Text("〜")
                    Text(dateFormatManager.getJapanDateDisplayFormatString(travel.endDate))
                }.font(.system(size: 12))
                    .frame(width: DeviceSizeManager.deviceWidth - 40)
                
            }
        }.padding([.horizontal, .bottom])
            .frame(width: DeviceSizeManager.deviceWidth - 20)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .foregroundStyle(.gray)
            .fontWeight(.bold)
            .background(.white)
            .compositingGroup()
            .shadow(color: .gray, radius: 2, x: 1, y: 1)
            .onAppear {
                viewModel.downloadImageUrl(fileName: travel.id.stringValue) { url in
                    self.url = url
                }
            }
    }
}
