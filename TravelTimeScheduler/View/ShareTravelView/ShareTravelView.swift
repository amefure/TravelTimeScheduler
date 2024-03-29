//
//  ShareTravelView.swift
//  TravelTimeScheduler
//
//  Created by t&a on 2023/05/18.
//

import SwiftUI

struct ShareTravelView: View {
    
    // MARK: - ViewModels
    private let dbControl = SwitchingDatabaseControlViewModel()
    
    // MARK: - Receive Parameters
    public let travel:Travel
    
    var body: some View {
        List{
            
            // MARK: - ImageView
            SectionImageView(image: "ShareId")
            
            Section(header: Text("TravelID"), footer: Text("・このIDは登録した旅行ごとに振られる一意のIDです。\n・このIDを友達に教えることで旅行をシェアできます。")) {
                
                HStack{
                    
                    Text(travel.id.stringValue)
                        .lineLimit(1)
                    
                    CopyButtonView(copyText: travel.id.stringValue)
                    
                }.textSelection(.enabled)
                    .floatingCard()
                
            }.listRowBackground(Color.list)
        }.foregroundColor(Color.thema)
            .navigationTitle("Share Travel")
            .navigationCustomBackground()
    }
}
