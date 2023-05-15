//
//  RowScheduleView.swift
//  TravelTimeScheduler
//
//  Created by t&a on 2023/04/17.
//

import SwiftUI

struct RowScheduleView: View {
    
    // MARK: - ViewModels
    private let deviceSize = DeviceSizeViewModel()
    private let realmDataBase = RealmDatabaseViewModel()
    private let displayDate = DisplayDateViewModel()
    
    @ObservedObject var listScheduleVM = ListScheduleViewModel.shared
    
    // MARK: - Parameters
    public let travel:Travel
    public let schedule:Schedule
    
    // MARK: - View
    @State var selectedTranceportation:Tranceportation = .other   // 移動手段
    @State var change:Bool = false
    @State var isEditModal:Bool = false
    @State var isDeleteAlert:Bool = false

    
    var body: some View {
        VStack(spacing:0){
            
            // HStack #1
            HStack{
                
                // MARK: - 時間：20:00
                Text(displayDate.getTimeDisplayFormatString(schedule.dateTime))
                    .fontWeight(.bold)
                    .padding(.leading,5)
                    .frame(width: 65)
                
                // MARK: - スケジュールタイプ：空港
                ScheduleType.getScheduleTypeImage(schedule.type)
                    .scheduleTypeIcon(color: .accentSchedule)
                
                
                // MARK: - 内容：鹿児島空港
                Text(schedule.content)
                    .fontWeight(.bold)
                    .lineLimit(2)
                
                Spacer()
                
                // MARK: - 右上削除用ボタン
                if listScheduleVM.isDeleteMode {
                    Button {
                        isDeleteAlert = true
                    } label: {
                        Image(systemName: "minus")
                            .padding()
                            .frame(width: 20,height: 20)
                            .background(Color.negative)
                            .foregroundColor(.white)
                            .cornerRadius(20)
                    }.buttonStyle(BorderlessButtonStyle())
                        .offset(y: deviceSize.isSESize ? -8: -15)
                }
                
            }.padding(5)
                .frame(width:deviceSize.deviceWidth - 30 )
                .background(Color(hexString: "#73BBD1"))
                .padding(.bottom,3)
                .shadowCornerRadius()
                .onTapGesture {
                    if !listScheduleVM.isDeleteMode {
                        isEditModal = true
                    }
                }
            // HStack #1

            // HStack #2
            HStack{
                
                if schedule.tranceportation == nil {
                    
                    // MARK: - 交通手段登録ボタン
                    Button {
                        change.toggle()
                    } label: {
                        Image(systemName: "plus.square")
                            .padding()
                    }
                    
                }else{
                    if schedule.tranceportation != .none {
                        
                        // MARK: - 移動した軌跡用縦線
                        Rectangle().frame(width: 8,height: deviceSize.isSESize ? 40: 50)
                            .foregroundColor(Color(hexString: "#E7EB8D"))
                        
                        // MARK: - 交通手段変更ボタン
                        Button {
                            change.toggle()
                        } label: {
                            Tranceportation.getTranceportationTypeImage(schedule.tranceportation!)
                        }.foregroundColor(.gray)
                            .frame(width: 15)
                        
                    }
                }
                // MARK: - 交通手段変更リスト
                if change {
                    TranceportationPickerView(travel: travel, schedule: schedule, selectedTranceportation: $selectedTranceportation, change: $change)
                }else{
                    Spacer().frame(width: 170)
                }
                
            }// HStack #1
            .onAppear{
                if schedule.tranceportation != .none {
                    selectedTranceportation = schedule.tranceportation!
                }
            }
            .sheet(isPresented: $isEditModal) {
                EntryScheduleView(travel: travel,schedule: schedule, dateTime: schedule.dateTime,isModal: $isEditModal)
                    .presentationDetents([. medium])
            }
            .alert("このタイムスケジュールを\n削除しますか？", isPresented: $isDeleteAlert) {
                Button(role:.destructive) {
                    realmDataBase.deleteSchedule(travelId: travel.id, scheduleId: schedule.id)
                } label: {
                    Text("削除")
                }
            }
        } // VStack
    }
}
