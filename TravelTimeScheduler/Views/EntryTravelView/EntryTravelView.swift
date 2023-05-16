//
//  EntryTravelView.swift
//  TravelTimeScheduler
//
//  Created by t&a on 2023/04/13.
//

import SwiftUI
import RealmSwift

struct EntryTravelView: View {
    
    // MARK: - ViewModels
    private let realmDataBase = RealmDatabaseViewModel()
    private let deviceSize = DeviceSizeViewModel()
    
    // MARK: - TextField
    @State var travelName:String = ""      // 旅行名
    @State var memberArray:[String] = [""] // メンバー
    @State var startDate:Date = Date()     // 出発日
    @State var endDate:Date = Date()       // 帰宅日
    
    // MARK: - Parameters
    public let travel:Travel?
    public var parentDismissFunction: () -> Void
    
    // DeleteTravelButtonクリック時に画面をトップに戻す
    @Environment(\.dismiss) var dismiss
    
    private func backRootViewFunction() {
        self.dismiss()
        self.parentDismissFunction()
    }
    
    var body: some View {
        
        // MARK: - Header
        EntryHeaderView(travelName: travelName, memberArray: memberArray, startDate: startDate, endDate: endDate, travel: travel)
        
        // MARK: - Contents
        List{
            Section("Travel Name") {
                TextField("旅行名", text: $travelName)
                    .padding()
                    .background(Color.foundation)
                    .cornerRadius(5)
            }.listRowSeparator(.hidden)
            
            
            Section("Member") {
                InputMemberView(memberArray: $memberArray)
            } .listRowSeparator(.hidden)
            
            Section("Travel Period"){
                InputPeriodView(startDate: $startDate, endDate: $endDate)
            }.listRowSeparator(.hidden)
            
            Section("Setting"){
                
                if travel != nil {
                    HStack{
                        
                        Spacer()
                        Button {
                            
                        } label: {
                            Text("友達と共有する(工事中...)")
                        }
                        .padding(10)
                        .background(.gray)
                        .foregroundColor(.white)
                        .shadowCornerRadius()
                        Spacer()
                    }
                    HStack{
                        
                        Spacer()
                        DeleteTravelButtonView(travel: travel!, parentBackRootViewFunction: backRootViewFunction)
                            .foregroundColor(.negative)
                        Spacer()
                    }
                }
            }.listRowSeparator(.hidden)
        }
        .fontWeight(.bold)
        .listStyle(GroupedListStyle())
        .scrollContentBackground(.hidden)
        .navigationCustomBackground()
        .onAppear{
            /// 　初期値セット
            if travel != nil{
                travelName = travel!.name
                memberArray = Array(travel!.members)
                startDate = travel!.startDate
                endDate = travel!.endDate
            }else{
                let myName = SignInUserInfoViewModel.shared.signInUserName
                memberArray = [myName]
            }
        }
    }
}
