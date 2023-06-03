//
//  ShareTravelView.swift
//  TravelTimeScheduler
//
//  Created by t&a on 2023/05/18.
//

import SwiftUI

struct ShareTravelView: View {
    
    public let travel:Travel
    
    private let dbControl = SwitchingDatabaseControlViewModel.shared
    private let signInUserInfo = SignInUserInfoViewModel()
    
    var body: some View {
        List{
            
            // MARK: - ImageView
            SectionImageView(image: "ShareId")
            
            if travel.share {
                
                Section(header: Text("TravelID"), footer: Text("・このIDは登録した旅行ごとに振られる一意のIDです。\n・このIDを友達に教えることで旅行をシェアできます。")) {
                    
                    HStack{
                        
                        Text(travel.id.stringValue)
                        
                        CopyButtonView(copyText: travel.id.stringValue)
                        
                    }.padding()
                        .foregroundColor(.gray)
                        .frame(width: DeviceSizeViewModel().deviceWidth - 60)
                        .fontWeight(.bold)
                        .background(.white)
                        .textSelection(.enabled)
                        .overlay(
                            RoundedRectangle(cornerRadius:5)
                                .stroke(Color.gray,lineWidth: 2)
                        )
                        .shadowCornerRadius()
                    
                }.listRowBackground(Color.list)
            }else{
                Section {
                    
                    Button {
                        dbControl.updateShareTravel(travel: travel, share: true)
                        dbControl.entryTravel(travel: travel)
//                        dbControl.addUserReadableTravelId(userId: signInUserInfo.signInUserId, travelId: travel.id.stringValue)
                    } label: {
                        Text("TravelIDを発行する")
                    }
                    
                } header: {
                    Text("Share")
                } footer: {
                    Text("友達と共有するにはTravelIDを発行する必要があります。")
                }
            }
            
        }.foregroundColor(Color.thema)
            .navigationTitle("Share Travel")
            .navigationCustomBackground()
    }
}
