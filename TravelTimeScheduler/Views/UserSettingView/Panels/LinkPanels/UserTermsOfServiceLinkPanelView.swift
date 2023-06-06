//
//  UserTermsOfServiceLinkView.swift
//  TravelTimeScheduler
//
//  Created by t&a on 2023/05/03.
//

import SwiftUI

struct UserTermsOfServiceLinkPanelView: View {
    
    var body: some View {
        Link(destination:URL.init(string: "https://tech.amefure.com/app-terms-of-service")!,
          label: {
            VStack{
                Image(systemName:"note.text")
                    .font(.system(size: 40))
                    .frame(height: 40)
                Text("利用規約")
            }
        })
    }
}
