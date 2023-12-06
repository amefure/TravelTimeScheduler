//
//  EntryScheduleView.swift
//  TravelTimeScheduler
//
//  Created by t&a on 2023/04/14.
//

import SwiftUI
import RealmSwift

struct EntryScheduleView: View {
    // Entry & Update
    
    // MARK: - ViewModels
    private let validation = ValidationViewModel()
    private let dbControl = SwitchingDatabaseControlViewModel()
    private let displayDate = DisplayDateViewModel()
    private let deviceSize = DeviceSizeViewModel()
    
    
    @ObservedResults(Travel.self) var allTravelRelam
    
    // MARK: - Parameters
    public let travel:Travel
    public let schedule:Schedule?
    
    // MARK: - View
    @State var dateTime:Date = Date()                    // 開始時間
    @State var endDateTime:Date = Date()                 // 終了時間
    @State var content:String = ""                       // 内容
    @State var memo:String = ""
    @State var type:ScheduleType = .other                // タイプ
    
    @State var isEndDateTime: Bool = false               // 終了時間を登録するかどうか
    
    @Binding var isModal:Bool
    
    private func validatuonInput() -> Bool{
        validation.validateEmpty(str:content)
    }
    
    var body: some View {
        VStack(spacing:0){
            
            // MARK: - Header
            HeaderTitleView(title: schedule == nil ? "タイムスケジュール追加" : "編集")
                .frame(width: deviceSize.deviceWidth)
                .padding()
                .background(Color.thema)
            
            VStack(spacing:0){
                
                // MARK: - Input1
                HStack {
                    
                    Text("開始時間")
                        .foregroundColor(Color.gray)
                    
                    DatePicker("開始時間", selection: $dateTime, displayedComponents:[.hourAndMinute])
                        .datePickerStyle(.compact)
                        .colorInvert()
                        .colorMultiply(Color.foundation)
                        .labelsHidden()
                        .background(Color.schedule)
                        .shadowCornerRadius()
                        .padding(deviceSize.isSESize ? 8 : 15)
                        .environment(\.locale, Locale(identifier: "ja_JP"))
                        .environment(\.calendar, Calendar(identifier: .japanese))
                }
                
                
                // MARK: - Input1
               
                HStack {
                    Text("終了時間")
                        .foregroundColor(Color.gray)
                    
                    if isEndDateTime {
                        
                        ZStack {
                            DatePicker("終了時間", selection: $endDateTime, displayedComponents:[.hourAndMinute])
                                .datePickerStyle(.compact)
                                .colorInvert()
                                .colorMultiply(Color.foundation)
                                .labelsHidden()
                                .background(Color.schedule)
                                .shadowCornerRadius()
                                .padding(deviceSize.isSESize ? 8 : 15)
                                .environment(\.locale, Locale(identifier: "ja_JP"))
                                .environment(\.calendar, Calendar(identifier: .japanese))
                            
                            Button(action: {
                                isEndDateTime = false
                            }, label: {
                                Image(systemName: "minus.square.fill")
                                    .foregroundStyle(Color.negative)
                            }).offset(x: 50)
                        }
                       
                    } else {
                        Button(action: {
                            isEndDateTime = true
                        }, label: {
                            Image(systemName: "plus")
                                .padding(deviceSize.isSESize ? 8 : 15)
                                .frame(width: 60)
                                .background(Color.foundation)
                                .foregroundColor(Color.thema)
                                .cornerRadius(5)
                                .buttonStyle(.borderless)
                                .overlay {
                                    Rectangle()
                                        .stroke(style: StrokeStyle(dash: [5, 5]))
                                }.padding(deviceSize.isSESize ? 8 : 15)
                        })
                    }
                }
                
                
                // MARK: - Input2
                TextField("内容", text: $content)
                    .padding(10)
                    .background(Color.schedule)
                    .padding(.bottom,3)
                    .shadowCornerRadius()
                    .padding(deviceSize.isSESize ? 8 : 15)
                
                // MARK: - Input3
                TextField("Memo", text: $memo)
                    .padding(10)
                    .background(Color.list)
                    .padding(.bottom,3)
                    .cornerRadius(5)
                    .padding(deviceSize.isSESize ? 8 : 15)
                
                // MARK: - Input4
                ScheduleTypePickerView(type: $type)
                
                
                // MARK: - 登録ボタン
                Button {
                    if validatuonInput(){
                        if schedule == nil {
                            /// 新規登録
                            let sc = Schedule()
                            sc.content = content
                            sc.dateTime = dateTime
                            if isEndDateTime {
                                sc.endDateTime = endDateTime
                            }
                            sc.memo = memo
                            sc.type = type
                            sc.tranceportation = .none
                            
                            dbControl.addSchedule(travel: travel, schedule: sc)
                        }else{
                            var endTime: Date? = nil
                            if isEndDateTime {
                                endTime = endDateTime
                            }
                            /// 更新処理
                            dbControl.updateSchedule(travelId: travel.id.stringValue, scheduleId: schedule!.id.stringValue, dateTime: dateTime, endDateTime: endTime, content: content,memo: memo, type: type, tranceportation: schedule!.tranceportation)
                            
                        }
                        isModal = false
                    }
                } label: {
                    Text(schedule == nil ? "追加" : "更新")
                }.padding(deviceSize.isSESize ? 8 : 10)
                    .background(validatuonInput() ? Color.thema :.gray)
                    .foregroundColor(.white)
                    .shadowCornerRadius()
                    .accessibilityIdentifier("addScheduleButton")
                
            }.frame(maxWidth: deviceSize.deviceWidth - 40)
            
            Spacer()
            
            // MARK: - AdMob
            if !deviceSize.isSESize {
                AdMobBannerView()
                    .frame(height: 60)
            }
            
        }.padding(.horizontal)
            .onAppear{
                /// 　初期値セット
                if let schedule = schedule {
                    /// 　更新時は対象データを格納
                    dateTime = schedule.dateTime
                    if let endTime = schedule.endDateTime {
                        endDateTime = endTime
                        isEndDateTime = true
                    } else {
                        endDateTime = displayDate.startOfDay(endDateTime)
                        isEndDateTime = false
                    }
                    content = schedule.content
                    memo = schedule.memo
                    type = schedule.type
                }else{
                    /// 　新規登録時は時間のみリセット
                    dateTime = displayDate.startOfDay(dateTime)
                    endDateTime = displayDate.startOfDay(endDateTime)
                    isEndDateTime = false
                }
            }
    }
}
