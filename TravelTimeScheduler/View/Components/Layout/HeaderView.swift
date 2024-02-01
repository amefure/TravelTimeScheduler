//
//  HeaderView.swift
//  TravelTimeScheduler
//
//  Created by t&a on 2024/01/31.
//

import SwiftUI

struct HeaderView: View {
    
    // MARK: - Receive
    public var title: String = ""
    public var leadingIcon: String = ""
    public var trailingIcon: String  = ""
    public var leadingAction: () -> Void = {}
    public var trailingAction: () -> Void = {}
    
    public var isShowMenu: Bool = false
    public var members: [String] = []
    
    var body: some View {
        HStack {
            
            if !leadingIcon.isEmpty {
                
                Button {
                    leadingAction()
                } label: {
                    Image(systemName: leadingIcon)
                        .font(.system(size: 18))
                }.padding(.leading, 5)
                    .frame(width: 50)
            } else if !trailingIcon.isEmpty {
                Spacer()
                    .frame(width: 50)
            }
            
            Spacer()
            
            Text(title)
                .foregroundColor(Color.foundation)
                .fontWeight(.bold)
                .font(.system(size: 18,design:.monospaced))
                .contextMenu {
                    if isShowMenu {
                        if members.first == "" {
                            Text("No Member")
                        } else {
                            ForEach(members, id: \.self) { member in
                                Text(member)
                            }
                        }
                    }
                }
            
            Spacer()
            
            if !trailingIcon.isEmpty {
                Button {
                    trailingAction()
                } label: {
                    Image(systemName: trailingIcon)
                        .font(.system(size: 18))
                }.padding(.trailing, 5)
                    .frame(width: 50)
            } else if !leadingIcon.isEmpty {
                Spacer()
                    .frame(width: 50)
            }
        }.foregroundStyle(.white)
            .padding()
            .background(Color.thema)
    }
}

#Preview {
    HeaderView()
}
