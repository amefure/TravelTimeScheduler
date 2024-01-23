//
//  SignOutButtonView.swift
//  TravelTimeScheduler
//
//  Created by t&a on 2023/04/06.
//

import SwiftUI

struct UserSignUpLinkPanelView: View {
    
    var body: some View {
        NavigationLink {
            NewEntryAuthView()
        } label: {
            VStack{
                Image(systemName: "person.fill.checkmark")
                    .font(.system(size: 40))
                    .frame(height: 40)
                Text("Sign Up")
            }
        }
    }
}
