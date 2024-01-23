//
//  AccordionBoxView.swift
//  TravelTimeScheduler
//
//  Created by t&a on 2023/06/09.
//

import SwiftUI

struct AccordionBoxView: View {
    
    let question:String
    let answer:String
    @State var isClick:Bool = false
    
    var body: some View {
        HStack{
            Image(systemName: "questionmark")
                .opacity(0.5)
                .fontWeight(.bold)
                .foregroundColor(Color.thema)
            
            Text(question)
                .font(.system(size: 15))
                .foregroundColor(Color(hexString: "#333333"))
            
            Spacer()
            
            Button {
                isClick.toggle()
            } label: {
                Image(systemName: isClick ? "minus" : "plus")
                    .foregroundColor(isClick ? Color.negative : Color.schedule)
                    .fontWeight(.bold)
                    .opacity(0.8)
            }
        }
        if isClick {
            Text(answer)
                .font(.system(size: 13))
                .foregroundColor(.gray)
        }
    }
}
