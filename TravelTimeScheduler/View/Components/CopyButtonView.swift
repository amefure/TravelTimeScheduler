//
//  CopyButtonView.swift
//  TravelTimeScheduler
//
//  Created by t&a on 2023/05/31.
//

import SwiftUI

struct CopyButtonView: View {
    
    @ObservedObject var messageAlertVM = MessageBalloonViewModel()
    
    public let copyText:String
    
    var body: some View {
        ZStack {
            if (messageAlertVM.isPreview){
                Text("コピーしました")
                    .font(.system(size: 8))
                    .padding(3)
                    .background(Color(red: 0.3, green: 0.3 ,blue: 0.3))
                    .foregroundColor(.white)
                    .opacity(messageAlertVM.castOpacity())
                    .cornerRadius(5)
                    .offset(x: 0, y: -20)
            }
            
            Button(action: {
                UIPasteboard.general.string = copyText
                messageAlertVM.show()
                messageAlertVM.vanishMessage()
                
            }, label: {
                Image(systemName: "doc.on.doc")
                    .foregroundColor(.gray)
                    .frame(width: 65)
            }).disabled(messageAlertVM.isPreview)
            
        }
    }
}
