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
    @State var isEditModal:Bool = false
    @State var isDeleteAlert:Bool = false

    
    var body: some View {
        VStack(spacing:0){
            
            // MARK: - UpSide
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
                    // DeleteModeでなければ編集モーダル
                    if !listScheduleVM.isDeleteMode {
                        isEditModal = true
                    }
                }

            // MARK: - DownSide
            RowTranceportationView(travel: travel, schedule: schedule)
            
        } // VStack
        .sheet(isPresented: $isEditModal) {
            EntryScheduleView(travel: travel,schedule: schedule, dateTime: schedule.dateTime,isModal: $isEditModal)
                .presentationDetents([.medium])
        }
        .alert("このタイムスケジュールを\n削除しますか？", isPresented: $isDeleteAlert) {
            Button(role:.destructive) {
                realmDataBase.deleteSchedule(travelId: travel.id, scheduleId: schedule.id)
            } label: {
                Text("削除")
            }
        }
    }
}
