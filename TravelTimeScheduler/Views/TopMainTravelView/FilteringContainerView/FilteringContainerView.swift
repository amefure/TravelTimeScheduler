//
//  FilteringContainerView.swift
//  TravelTimeScheduler
//
//  Created by t&a on 2023/06/06.
//

import SwiftUI

struct FilteringContainerView: View {
    
    @Binding var searchText:String
    @Binding var selectTime:String
    
    var body: some View {
        HStack{
            // MARK: - 文字列フィルタリング
            SearchBoxView(searchText: $searchText)
            
            // MARK: - 日付フィルタリング
            PickerTimeView(selectTime: $selectTime)
            
            // MARK: - フィルタリングリセット
            Button {
                searchText = ""
                selectTime = "all"
            } label: {
                Image(systemName: "list.triangle")
                    .foregroundColor(selectTime != "all" || searchText != "" ? .accentSchedule : .foundation)
            }
            
            Spacer()
        }
    }
}
