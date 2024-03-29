//
//  TranceportationPickerView.swift
//  TravelTimeScheduler
//
//  Created by t&a on 2023/04/24.
//

import SwiftUI

struct TranceportationPickerView: View {
    
    // MARK: - ViewModels
    private let dbControl = SwitchingDatabaseControlViewModel()
    
    // MARK: - Parameters
    let travel:Travel
    let schedule:Schedule
    
    @Binding var selectedTranceportation:Tranceportation
    @Binding var displaytChange:Bool
    
    // MARK: - Models
    public let allCases:[Tranceportation] = Tranceportation.allCases
    
    var body: some View {
        ScrollView(.horizontal){
            LazyHStack{
                ForEach(allCases, id: \.self) { item in
                    Button {
                        selectedTranceportation = item
                    } label: {
                        Tranceportation.getTranceportationTypeImage(item)
                            .scheduleTypeIcon(color: selectedTranceportation == item ? Color.negative : .gray)
                            .foregroundColor(Color.foundation)
                    }
                }
            }
                .onChange(of: selectedTranceportation) { newValue in
                    displaytChange = false
                    dbControl.updateSchedule(travelId: travel.id.stringValue, scheduleId: schedule.id.stringValue, dateTime: schedule.dateTime, endDateTime: schedule.endDateTime, content: schedule.content, memo:schedule.memo,type: schedule.type, tranceportation: selectedTranceportation)
                }
        }
    }
}
