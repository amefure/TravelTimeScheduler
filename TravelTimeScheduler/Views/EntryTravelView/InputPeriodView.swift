//
//  InputPeriodView.swift
//  TravelTimeScheduler
//
//  Created by t&a on 2023/04/28.
//

import SwiftUI

struct InputPeriodView: View {
    
    // MARK: - Parameters
    @Binding var startDate:Date
    @Binding var endDate:Date
    
    // MARK: -　帰宅日として選択できる範囲をフレキシブルに変更
    @State var endDateRange:ClosedRange<Date> = {
        let calender = Calendar.current
        let start = Date()
        let end = calender.date(byAdding: .year, value: 10, to: Date())!
        return start...end
    }()
    
    
    var body: some View {
        
            DatePicker("出発日", selection: $startDate,displayedComponents: [.date])
                .datePickerStyle(.compact)
                .accentColor(.thema)
                .fontWeight(.bold)
                .colorInvert()
                .colorMultiply(.thema)
                .environment(\.locale, Locale(identifier: "ja_JP"))
                .environment(\.calendar, Calendar(identifier: .japanese))
                .onChange(of: startDate) { newValue in
                    endDateRange = newValue...Calendar.current.date(byAdding: .year, value: 10, to: Date())!
                }
            
            DatePicker("帰宅日", selection: $endDate,in:endDateRange,displayedComponents: [.date])
                .datePickerStyle(.compact)
                .accentColor(.thema)
                .fontWeight(.bold)
                .colorInvert()
                .colorMultiply(.thema)
                .environment(\.locale, Locale(identifier: "ja_JP"))
                .environment(\.calendar, Calendar(identifier: .japanese))

    }
}
