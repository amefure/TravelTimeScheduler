//
//  AuthInputBoxView.swift
//  TravelTimeScheduler
//
//  Created by t&a on 2023/05/08.
//

import SwiftUI

struct AuthInputBoxView: View {
    
    public let isLogin:Bool
    
    @Binding var name:String
    @Binding var email:String
    @Binding var password:String
    
    var body: some View {
        VStack{
            
            HStack{
                Text("アカウント情報")
                    .foregroundColor(.gray)
                    .font(.caption)
                    .padding([.horizontal,.top])
                    .fontWeight(.bold)
                Spacer()
            }
            
            Group {
                if !isLogin {
                    TextField("ユーザー名", text: $name)
                }
                TextField("メールアドレス", text: $email)
                SecureInputView(password: $password)
            }.padding()
                .font(.system(size: DeviceSizeManager.isSESize ? 15 : 20))
                .fontWeight(.bold)
                .overlay(
                    RoundedRectangle(cornerRadius:5)
                        .stroke(Color.gray,lineWidth: 2)
                )
                .padding(.horizontal)
        }
    }
}
