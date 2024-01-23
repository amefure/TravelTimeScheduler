//
//  UserReviewLinkView.swift
//  TravelTimeScheduler
//
//  Created by t&a on 2023/05/03.
//

import SwiftUI

struct UserReviewLinkPanelView: View {
    
    var body: some View {
        Link(destination:URL.init(string: "https://apps.apple.com/jp/app/%E6%97%85time/id6449208868?action=write-review")!,
          label: {
            VStack{
                Image(systemName:"hand.thumbsup")
                    .font(.system(size: 40))
                    .frame(height: 40)
                Text("レビュー")
            }
        })
    }
}
