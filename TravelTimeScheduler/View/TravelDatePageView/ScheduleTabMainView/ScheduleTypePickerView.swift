//
//  PickerTypeView.swift
//  TravelTimeScheduler
//
//  Created by t&a on 2023/04/23.
//

import SwiftUI

struct ScheduleTypePickerView: View {
    
    @Binding var type:ScheduleType
    public let allCases:[ScheduleType] = ScheduleType.allCases
    
    var body: some View {
        ScrollView(.horizontal){
            LazyHStack{
                ForEach(allCases, id: \.self) { item in
                    Button {
                        type = item
                    } label: {
                        VStack{
                            ScheduleType.getScheduleTypeImage(item)
                                .scheduleTypeIcon(color: type == item ? Color.negative : .gray)
                                .foregroundColor(Color.foundation)
                            Text(item.rawValue)
                                .font(.caption)
                                .foregroundColor(type == item ? Color.negative : .gray)
                        }
                    }
                }
            }
        }
    }
}
