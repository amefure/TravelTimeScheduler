//
//  Modifier.swift
//  TravelTimeScheduler
//
//  Created by t&a on 2023/04/20.
//

import SwiftUI

struct ScheduleTypeIcon: ViewModifier {
    
    public let color:Color
    
    func body(content: Content) -> some View {
        content
            .frame(width: DeviceSizeManager.isSESize ? 15 : 25 ,height: DeviceSizeManager.isSESize ? 15 : 25)
            .padding(10)
            .background(color)
            .font(.system(size: 20))
            .cornerRadius(30)
    }
}

struct FloatingCard:ViewModifier{
    func body(content: Content) -> some View {
        content
            .padding()
                .foregroundColor(.gray)
                .frame(width: DeviceSizeManager.deviceWidth - 40)
                .fontWeight(.bold)
                .background(.white)
                .overlay(
                    RoundedRectangle(cornerRadius:5)
                        .stroke(Color.gray,lineWidth: 2)
                )
                .shadowCornerRadius()
    }
}

struct NavigationCustomBackground:ViewModifier{
    func body(content: Content) -> some View {
        content
            .toolbarBackground(Color(hexString: "#34527B"),for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarColorScheme(.dark)
    }
}

struct ShadowCornerRadius:ViewModifier{
    func body(content: Content) -> some View {
        content
            .cornerRadius(5)
            .shadow(color: .gray,radius: 3, x: 2, y: 2)
    }
}
    
   

extension View {
    func scheduleTypeIcon(color:Color) -> some View {
        modifier(ScheduleTypeIcon(color: color))
    }
    
    func floatingCard() -> some View {
        modifier(FloatingCard())
    }
    
    func navigationCustomBackground() -> some View {
        modifier(NavigationCustomBackground())
    }
    
    func shadowCornerRadius() -> some View{
        modifier(ShadowCornerRadius())
    }
}
