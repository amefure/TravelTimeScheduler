//
//  ScheduleTabMainView.swift
//  TravelTimeScheduler
//
//  Created by t&a on 2023/04/21.
//

import SwiftUI

struct ScheduleTabMainView: View {
    
    // MARK: - Parameters
    public let travel:Travel
    @Binding var selection:Int
    @Binding var isDeleteMode:Bool
    
    var body: some View {
        TabView(selection: $selection) {
            ForEach(travel.allTravelPeriod, id: \.self) { item in
                VStack(spacing:0){
                    ListScheduleView(travel: travel, dateTime: item).tag(travel.allTravelPeriod.firstIndex(of: item)!)
                    
                }.tag(travel.allTravelPeriod.firstIndex(of: item)!)
            }
        }.tabViewStyle(.page)
    }
}
