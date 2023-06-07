//
//  UserinfoEditView.swift
//  TravelTimeScheduler
//
//  Created by t&a on 2023/05/03.
//

import SwiftUI

struct UserinfoEditLinkPanelView: View {
    
    var body: some View {
        NavigationLink {
            EditUserNameView()
        } label: {
            VStack{
                Image(systemName: "rectangle.and.pencil.and.ellipsis")
                    .font(.system(size: 40))
                    .frame(height: 40)
                Text("Edit User")
            }
        }
    }
}
