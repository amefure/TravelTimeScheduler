//
//  EntryHeaderView.swift
//  TravelTimeScheduler
//
//  Created by t&a on 2023/05/10.
//

import SwiftUI

struct EntryHeaderView: View {
    
    // MARK: - ViewModels
    private let validation = ValidationViewModel()
    private let realmDataBase = SwitchingDatabaseControlViewModel.shared
    
    // MARK: - TextField
    public let travelName:String        // 旅行名
    public let memberArray:[String]     // メンバー
    public let startDate:Date           // 出発日
    public let endDate:Date             // 帰宅日
    
    // MARK: - Parameters
    public let travel:Travel?
    
    // MARK: - View
    @State var isAlert:Bool = false
    
    private func validatuonInput() -> Bool{
        validation.validateEmpty(str:travelName)
    }
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        
        HStack{
            
            Button {
                self.dismiss()
            } label: {
                Label("戻る", systemImage: "chevron.backward")
            }.foregroundColor(Color.foundation)
                .fontWeight(.bold)
            
            
            Spacer()
            
            HeaderTitleView(title: "旅行登録")
            
            Spacer()
            
            Button(action: {
                if validatuonInput() {
                    
                    if travel == nil {
                        // 新規登録処理
                        realmDataBase.createTravel(travelName: travelName,members: memberArray, startDate: startDate,endDate: endDate)
                        
                    }else{
                        // 更新処理
                        realmDataBase.updateTravel(id: travel!.id.stringValue, travelName: travelName,members: memberArray, startDate: startDate, endDate: endDate, schedules: travel!.schedules)
                    }
                    
                    isAlert = true
                }
                
            }, label: {
                Text(travel == nil ? "登録" : "更新")
            }).padding()
                .foregroundColor(validatuonInput() ?.accentSchedule:.gray)
                .fontWeight(.bold)
        }.padding()
            .background(Color.thema)
            .alert(travel == nil ? "「\(travelName)」を登録しました。" : "「\(travelName)」を更新しました。", isPresented: $isAlert) {
                Button {
                    dismiss()
                } label: {
                    Text("OK")
                }
            }
    }
}
