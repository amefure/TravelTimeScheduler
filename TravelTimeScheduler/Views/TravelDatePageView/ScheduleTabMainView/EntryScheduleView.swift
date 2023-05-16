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
    private let realmDataBase = RealmDatabaseViewModel()
    private let displayDate = DisplayDateViewModel()
    private let deviceSize = DeviceSizeViewModel()
    
    @ObservedResults(Travel.self) var allTravelRelam
    
    // MARK: - Parameters
    public let travel:Travel
    public let schedule:Schedule?
    
    // MARK: - View
    @State var dateTime:Date = Date()                    // 時間
    @State var content:String = ""                       // 内容
    @State var type:ScheduleType = .other                // タイプ
    
    @Binding var isModal:Bool
    
    private func validatuonInput() -> Bool{
        validation.checkNonEmptyText(content)
    }
    
    var body: some View {
        VStack(spacing:0){
            
            // MARK: - Header
            HeaderTitleView(title: schedule == nil ? "タイムスケジュール追加" : "更新")
                .frame(width: deviceSize.deviceWidth)
                .padding()
                .background(Color.thema)
            
            // MARK: - Input1
            DatePicker("時間", selection: $dateTime,displayedComponents:[.hourAndMinute])
                .datePickerStyle(.compact)
                .colorInvert()
                .colorMultiply(Color.foundation)
                .labelsHidden()
                .background(Color(hexString: "#73BBD1"))
                .shadowCornerRadius()
                .padding(deviceSize.isSESize ? 10 : 15)
                .environment(\.locale, Locale(identifier: "ja_JP"))
                .environment(\.calendar, Calendar(identifier: .japanese))
                
            // MARK: - Input2
            TextField("内容", text: $content)
                .padding(10)
                .background(Color(hexString: "#73BBD1"))
                .padding(.bottom,3)
                .shadowCornerRadius()
                .padding(deviceSize.isSESize ? 10 : 15)
            
            // MARK: - Input3
            ScheduleTypePickerView(type: $type)
            
            
            // MARK: - 登録ボタン
            Button {
                if validatuonInput(){
                    if schedule == nil {
                        /// 新規登録
                        let sc = Schedule()
                        sc.content = content
                        sc.dateTime = dateTime
                        sc.type = type
                        sc.tranceportation = .none
                        
                        realmDataBase.addSchedule(id: travel.id, schedule: sc)
                    }else{
                        /// 更新処理
                        realmDataBase.updateSchedule(travelId: travel.id, scheduleId: schedule!.id, dateTime: dateTime, content: content, type: type, tranceportation: schedule!.tranceportation)
                        
                    }
                    isModal = false
                }
            } label: {
                Text(schedule == nil ? "追加" : "編集")
            }.padding(deviceSize.isSESize ? 10 : 15)
                .background(validatuonInput() ? Color.thema :.gray)
                .foregroundColor(.white)
                .shadowCornerRadius()
                .accessibilityIdentifier("addScheduleButton")
            
            
            Spacer()
            
            // MARK: - AdMob
            AdMobBannerView().frame(width: deviceSize.deviceWidth,height: 60)
            
        }.padding(.horizontal)
            .onAppear{
                /// 　初期値セット
                if schedule != nil{
                    /// 　更新時は対象データを格納
                    dateTime = schedule!.dateTime
                    content = schedule!.content
                    type = schedule!.type
                }else{
                    /// 　新規登録時は時間のみリセット
                    dateTime = displayDate.startOfDay(dateTime)
                }
            }
    }
}
