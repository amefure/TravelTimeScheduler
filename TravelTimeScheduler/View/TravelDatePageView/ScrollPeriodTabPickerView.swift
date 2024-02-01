//
//  ScrollPeriodHeaderView.swift
//  TravelTimeScheduler
//
//  Created by t&a on 2023/04/21.
//

import SwiftUI
import RealmSwift

// MARK: - 日付タブピッカー
struct ScrollPeriodTabPickerView: View {
    
    // MARK: - Utility
    private let dateFormatManager = DateFormatManager()
    
    // MARK: - Parameters
    public let travel: Travel
    @Binding var selection: Int
    
    var body: some View {
        ScrollView(.horizontal) {
            LazyHStack (spacing: 3) {
                ForEach(travel.allTravelPeriod, id: \.self) { item in
                    
                    Button {
                        selection = travel.allTravelPeriod.firstIndex(of: item)!
                    } label: {
                        VStack(spacing:0){
                            Text(dateFormatManager.getShortDateDisplayFormatString(item))
                                .padding(5)
                            Rectangle()
                                .frame(height: 5)
                        }.frame(width: 70)
                            .fontWeight(.bold)
                            .foregroundColor(selection == travel.allTravelPeriod.firstIndex(of: item)! ? .accentSchedule :.foundation)
                    }
                }
            }.frame(height: 30)
                .padding(.bottom, 8)
        }.padding(.horizontal, 5)
    }
}
