//
//  ShareTravelView.swift
//  TravelTimeScheduler
//
//  Created by t&a on 2023/05/18.
//

import SwiftUI

struct ShareTravelView: View {
    
    public let travel:Travel
    
    private let realmDatabaseVM = SwitchingDatabaseControlViewModel.shared
    private let signInUserInfo = SignInUserInfoViewModel()
    
    var body: some View {
        List{
            
            Section {
                Button {
                    realmDatabaseVM.updateShareTravel(travel: travel, share: true)
                    realmDatabaseVM.entryTravel(travel: travel)
                } label: {
                    HStack{
                        Text("TravelIDを発行する")
                        if travel.share {
                            Text("発行済")
                                .font(.caption)
                                .padding(5)
                                .foregroundColor(.foundation)
                                .background(Color.negative)
                                .opacity(0.8)
                                .cornerRadius(15)
                                .overlay {
                                    RoundedRectangle(cornerRadius: 15)
                                          .stroke(Color.negative,lineWidth: 2)
                                }
                                
                        }
                    }
                    
                }.disabled(travel.share) // 発行済みなら再発行不可にする
            } header: {
                Text("Share")
            } footer: {
                Text("友達と共有するにはTravelIDを発行する必要があります。")
            }
            
            if travel.share {
                
                Section("TravelID") {
                    Text("64648ef93e61168821a55623")
                        .padding()
                        .foregroundColor(.gray)
                        .frame(width: DeviceSizeViewModel().deviceWidth - 90)
                        .fontWeight(.bold)
                        .background(.white)
                        .overlay(
                            RoundedRectangle(cornerRadius:5)
                                .stroke(Color.gray,lineWidth: 2)
                        )
                        .shadowCornerRadius()
                }.listRowBackground(Color.list)
                
            }
            
            Button {
                realmDatabaseVM.readAllTravel()
            } label: {
                Text("readAllTravel")
            }
            
        }.foregroundColor(Color.thema)
            .navigationTitle("Share Travel")
            .navigationCustomBackground()
    }
}
