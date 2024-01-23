//
//  ProgressButtonStack.swift
//  TravelTimeScheduler
//
//  Created by t&a on 2023/05/29.
//

import SwiftUI

struct ProgressButtonStack<Content: View>: View {
    
    private let content: () -> Content
    
    @Binding var isClick:Bool
    
    init(isClick:Binding<Bool>,@ViewBuilder content: @escaping () -> Content) {
        self._isClick = isClick
        self.content = content
    }
    
    var body: some View {
        VStack {
            if isClick {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    .fontWeight(.bold)
                    .buttonStyle(BorderlessButtonStyle())
            } else {
                content()
            }
        }
    }
}
