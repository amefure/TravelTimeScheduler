//
//  SearchBoxView.swift
//  TravelTimeScheduler
//
//  Created by t&a on 2023/05/03.
//

import SwiftUI

// MARK: - 検索ボックス
struct SearchBoxView: View {
    
    @State var inputText:String = ""
    @Binding var searchText:String
    
    var body: some View {
        HStack{
            Image(systemName: "magnifyingglass").font(.system(size: 15))
            TextField("東京旅行", text: $inputText).lineLimit(1)
            Button(action: {
                searchText = inputText
            }, label: {
                Text("検索")
                    .foregroundColor(inputText.isEmpty ? .gray :.negative)
            })
        }.padding(8)
            .background(Color.foundation)
            .opacity(0.8)
            .cornerRadius(10)
            .padding()
            .fontWeight(.bold)
    }
}
