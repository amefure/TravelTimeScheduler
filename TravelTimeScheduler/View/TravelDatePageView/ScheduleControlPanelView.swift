//
//  ScheduleControlPanelView.swift
//  TravelTimeScheduler
//
//  Created by t&a on 2023/04/21.
//

import SwiftUI

struct ScheduleControlPanelView: View {
    
    // MARK: - ViewModels
    @ObservedObject var listScheduleVM = ListScheduleViewModel.shared
    
    // MARK: - Parameters
    public let travel:Travel
    @Binding var isDeleteMode:Bool
    @Binding var selection:Int
    
    // MARK: - View
    @State var isOn:Bool = false
    @State var isEntrySchedulePresented:Bool = false
    @State var isEditTravelPresented:Bool = false
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        
        HStack{
            
            // MARK: - 左ボタン
            Button {
                isEditTravelPresented.toggle()
            } label: {
                Text("旅行編集")
            }.frame(width: 80,height: 45)
                .foregroundColor(Color.thema)
                .background(Color.foundation)
                .shadowCornerRadius()
            
            // MARK: - 中央ボタン
            Button {
                isEntrySchedulePresented.toggle()
            } label: {
                HStack{
                    Spacer().frame(width: 5)
                    Image(systemName: "plus")
                        .padding(10)
                        .background(Color.accentSchedule)
                        .cornerRadius(30)
                    Text("追加")
                        .frame(width: 50)
                        .multilineTextAlignment(.center)
                }
                
            }.foregroundColor(Color(hexString: "#333333"))
                .frame(width: 140,height: 55)
                .background(Color.schedule)
                .shadowCornerRadius()
            
            
            // MARK: - 右ボタン
            Toggle(isOn: $isOn) {
                // TimeSchedule DeleteMode ScheduleTabMainView.swift > List > Row 
                Text("削除")
                
            }.onChange(of: isOn) { newValue in
                listScheduleVM.toggleDeleteMode()
            }.frame(width: 80,height: 45)
                .foregroundColor( isOn ? .white:Color.negative)
                .tint(Color.negative) // Toggle Background
                .background(isOn ? Color.negative :Color.foundation)
                .toggleStyle(.button)
                .shadowCornerRadius()
            
        }.padding()
            .fontWeight(.bold)
            .sheet(isPresented: $isEntrySchedulePresented) {
                EntryScheduleView(travel: travel,schedule: nil, dateTime: travel.allTravelPeriod[selection],isModal: $isEntrySchedulePresented)
                    .presentationDetents([.medium])
            }
            .sheet(isPresented: $isEditTravelPresented){
                EntryTravelView(travel:travel,parentDismissFunction: {
                    self.dismiss()
                })
            }
    }
}
