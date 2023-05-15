//
//  SecureInputView.swift
//  TravelTimeScheduler
//
//  Created by t&a on 2023/03/31.
//

import SwiftUI

struct SecureInputView: View {

    // MARK: - FocusState
    @FocusState var focusText: Bool
    @FocusState var focusSecure: Bool
    
    // MARK: - プロパティ
    @State var show: Bool = false
    @Binding var password: String

    var body: some View {
        HStack {
            ZStack(alignment: .trailing) {
                
                // MARK: - 通常
                TextField("パスワード", text: $password)
                    .focused($focusText)
                    .opacity(show ? 1 : 0)
                
                // MARK: - パスワード
                SecureField("パスワード", text: $password)
                    .focused($focusSecure)
                    .opacity(show ? 0 : 1)
                
                
                // MARK: - ON/OFF Switch
                Button(action: {
                    show.toggle()
                    if show {
                        focusText = true
                    } else {
                        focusSecure = true
                    }
                }, label: {
                    Image(systemName: self.show ? "eye.slash.fill" : "eye.fill")
                        .padding(5)
                        .frame(height: 18)
                        .font(.system(size: 18))
                        .foregroundColor(self.show ? .gray : .thema)
                })
            }
        }
    }
}
