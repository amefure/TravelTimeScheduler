//
//  RowTranceportationView.swift
//  TravelTimeScheduler
//
//  Created by t&a on 2023/05/16.
//

import SwiftUI

struct RowTranceportationView: View {
    
    // MARK: - ViewModels
    private let deviceSize = DeviceSizeViewModel()
    
    // MARK: - Parameters
    public let travel:Travel
    public let schedule:Schedule
    
    // MARK: - View
    @State var selectedTranceportation:Tranceportation = .other   // 移動手段
    @State var displaytChange:Bool = false

    var body: some View {
        HStack{
            
            // スケジュールの交通手段が未設定なら
            if schedule.tranceportation == nil || schedule.tranceportation == .unowned {
                
                // MARK: - 交通手段登録ボタン
                Button {
                    displaytChange.toggle()
                } label: {
                    Image(systemName: "plus.square")
                        .padding()
                }.foregroundColor(.thema)
                
            }else{
                // スケジュールの交通手段が登録ずみなら
                if schedule.tranceportation != .none {
                    
                    // MARK: - 移動した軌跡用縦線
                    Rectangle().frame(width: 8,height: deviceSize.isSESize ? 40: 50)
                        .foregroundColor(Color(hexString: "#E7EB8D"))
                    
                    // MARK: - 交通手段変更ボタン
                    Button {
                        displaytChange.toggle()
                    } label: {
                        Tranceportation.getTranceportationTypeImage(schedule.tranceportation!)
                    }.foregroundColor(.gray)
                        .frame(width: 15)
                    
                }
            }
            // MARK: - 交通手段変更リスト
            if displaytChange {
                TranceportationPickerView(travel: travel, schedule: schedule, selectedTranceportation: $selectedTranceportation, displaytChange: $displaytChange)
            }else{
                Spacer().frame(width: 170)
            }
        }
        .onAppear{
            if schedule.tranceportation != .none {
                selectedTranceportation = schedule.tranceportation!
            }
        }
    }
}
