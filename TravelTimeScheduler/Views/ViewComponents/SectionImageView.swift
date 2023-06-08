//
//  SectionImageView.swift
//  TravelTimeScheduler
//
//  Created by t&a on 2023/05/16.
//

import SwiftUI

struct SectionImageView: View {
    
    // MARK: - Parameters
    public let image:String
    
    var body: some View {
        Section {
            Image(image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 300  ,height: 160)
                .background(Color.list)
        }.listRowBackground(Color.list)
            .listRowSeparator(.hidden)
    }
}
