//
//  InputMemberView.swift
//  TravelTimeScheduler
//
//  Created by t&a on 2023/04/28.
//

import SwiftUI

struct InputMemberView: View {
    
    // MARK: - Parameters
    @Binding var memberArray:[String]
    
    private let columns = Array(repeating:GridItem(.fixed(140)), count: 2)
    
    var body: some View {
        ScrollView(.vertical){
            LazyVGrid(columns: columns) {
                ForEach(memberArray.indices, id: \.self) { i in
                    TextField("メンバー\(i + 1)", text: $memberArray[i])
                        .padding()
                        .background(Color.foundation)
                        .cornerRadius(5)
                }
                Button(action: {
                    memberArray.append("")
                }, label: {
                    Image(systemName: "plus")
                })
                .padding()
                .frame(width: 140)
                .background(Color.foundation)
                .foregroundColor(Color.thema)
                .cornerRadius(5)
                .buttonStyle(.borderless)
                .overlay{
                    Rectangle()
                        .stroke(style: StrokeStyle(dash: [5, 5]))
                        .frame(width: 140)
                }
            }
        }.frame(maxHeight: 140)
        Button(action: {
            // FocusStateだとindex of range Errorになるので明示的に元から解除
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            memberArray.removeLast()
        }, label: {
            Image(systemName: "person.fill.badge.minus")
        }).frame(width: 50)
            .padding(5)
            .background(Color.foundation)
            .foregroundColor(memberArray.count == 1  ? .gray : .negative)
            .disabled(memberArray.count == 1)
            .shadowCornerRadius()
            .buttonStyle(.borderless)
            .listRowSeparator(.hidden)
    }
}
