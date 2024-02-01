//
//  HeaderView.swift
//  TravelTimeScheduler
//
//  Created by t&a on 2024/01/31.
//

import SwiftUI

struct HeaderView: View {
    
    // MARK: - ViewModels
    private let authVM = AuthViewModel.shared
    
    // MARK: - Receive
    public var title: String = ""
    public var leadingIcon: String = ""
    public var trailingIcon: String  = ""
    public var leadingAction: () -> Void = {}
    public var trailingAction: () -> Void = {}
    
    public var isShowMenu: Bool = false
    public var members: [String] = []
    
    var body: some View {
        
        VStack {
            
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
                
                HeaderTitleView(title: title)
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
            }
            
            if !ReachabilityUtility().isAvailable && authVM.isSignIn {
                Text("ネットワークに未接続の場合はネットワーク接続後でないとデータの更新が反映されませんのでご注意ください")
                    .font(.caption)
                    .padding([.horizontal, .top])
            }
        }.foregroundStyle(.white)
            .padding(.vertical)
            .background(Color.thema)
    }
}

#Preview {
    HeaderView()
}
