//
//  UserinfoEditView.swift
//  TravelTimeScheduler
//
//  Created by t&a on 2023/05/03.
//

import SwiftUI

struct UserinfoEditView: View {
    
    // MARK: - View
    @State var isPresented:Bool = false
    
    var body: some View {
        Button {
            isPresented = true
        } label: {
            VStack{
                Image(systemName: "rectangle.and.pencil.and.ellipsis")
                    .font(.system(size: 40))
                    .frame(height: 40)
                Text("編集〜")
            }
        }.userPanelsShape()
        .navigationDestination(isPresented: $isPresented) {
            EditUserNameView()
        }
    }
}
