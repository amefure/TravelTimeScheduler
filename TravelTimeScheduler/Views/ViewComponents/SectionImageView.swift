//
//  SectionImageView.swift
//  TravelTimeScheduler
//
//  Created by t&a on 2023/05/16.
//

import SwiftUI

struct SectionImageView: View {
    
    // MARK: - ViewModels
    private let deviceSize = DeviceSizeViewModel()
    // MARK: - Parameters
    public let image:String
    
    var body: some View {
        Section {
            Image(image)
                .resizable()
                .frame(width: deviceSize.deviceWidth - 100  ,height: deviceSize.deviceWidth / 1.9)
                .background(Color.list)
        }.listRowBackground(Color.list)
            .listRowSeparator(.hidden)
    }
}