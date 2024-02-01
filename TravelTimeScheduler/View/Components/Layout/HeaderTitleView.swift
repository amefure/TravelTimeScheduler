//
//  HeaderView.swift
//  TravelTimeScheduler
//
//  Created by t&a on 2023/04/28.
//

import SwiftUI

struct HeaderTitleView: View {
    var title: String
    var body: some View {
        Text(title)
            .foregroundColor(Color.foundation)
            .fontWeight(.bold)
            .font(.system(size: 18, design: .monospaced))
    }
}
