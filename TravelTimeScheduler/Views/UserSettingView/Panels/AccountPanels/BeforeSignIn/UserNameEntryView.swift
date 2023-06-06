//
//  UserNameEntryView.swift
//  TravelTimeScheduler
//
//  Created by t&a on 2023/05/18.
//

import SwiftUI

struct UserNameEntryView: View {
    
    var body: some View {
        NavigationLink {
            EntryUserNameView()
        } label: {
            VStack{
                Image(systemName: "person.text.rectangle")
                    .font(.system(size: 40))
                    .frame(height: 40)
                Text("User Name")
            }
        }
    }
}
