//
//  PickerTimeView.swift
//  TravelTimeScheduler
//
//  Created by t&a on 2023/05/03.
//

import SwiftUI
import RealmSwift

// MARK: - フィルタリング用DataPicker
struct PickerTimeView: View {
    
    // MARK: - ViewModels
    private let displayDateViewModel = DisplayDateViewModel()
    @ObservedObject var allTravelFirebase = FBDatabaseTravelListViewModel.shared

    @Binding var selectTime:String
    private let authViewModel = AuthViewModel.shared
    
    private let dbControl = SwitchingDatabaseControlViewModel.shared // migrationのため必要
    @ObservedResults(Travel.self) var allTravelRelam
    
    // MARK: - リスト表示するべき年数
    private var timeArray:[String] {
        var array:[String] = ["all"]
        if authViewModel.isSignIn {
            for item in allTravelFirebase.Travels {
                let year = displayDateViewModel.getDateDisplayFormatString(item.startDate).prefix(4)
                array.append(String(year))
            }
        }else{
            
            
            for item in allTravelRelam {
                let year = displayDateViewModel.getDateDisplayFormatString(item.startDate).prefix(4)
                array.append(String(year))
            }
        }
        let timeSet = Set(array) // 重複値を除去
        return Array(timeSet).sorted().reversed()
    }
    
    var body: some View {
        HStack{
            
            Button {
                selectTime = "all"
            } label: {
                Image(systemName: "calendar")
                    .foregroundColor(selectTime != "all" ? .negative : .foundation)
            }
            Picker(selection: $selectTime, content: {
                ForEach(timeArray,id:\.self) { item in
                    Text(item)
                }
            }, label: {
            }).padding(.trailing)
                .frame(minWidth: 100)
                .tint(Color.foundation)
            
        }.fontWeight(.bold)
    }
}
