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
            .frame(width: DeviceSizeViewModel().isSESize ? 15 : 25 ,height: DeviceSizeViewModel().isSESize ? 15 : 25)
            .padding(10)
            .background(color)
            .font(.system(size: 20))
            .cornerRadius(30)
    }
}

struct UserPanelsShape:ViewModifier {
    
    func body(content: Content) -> some View {
        content
//            .padding()
//            .frame(width:DeviceSizeViewModel().deviceWidth/3 - 15,height: DeviceSizeViewModel().isSESize ? 90 : 120)
//            .background(.white)
//            .shadowCornerRadius()
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
    
    func userPanelsShape() -> some View{
        modifier(UserPanelsShape())
    }
    
    func navigationCustomBackground() -> some View {
        modifier(NavigationCustomBackground())
    }
    
    func shadowCornerRadius() -> some View{
        modifier(ShadowCornerRadius())
    }
}
