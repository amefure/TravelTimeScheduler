//
//  UserAllTravelDeleteView.swift
//  TravelTimeScheduler
//
//  Created by t&a on 2023/05/18.
//

import SwiftUI

struct UserAllTravelDeletePanelView: View {
    // MARK: - ViewModels
    private let dbControl = SwitchingDatabaseControlViewModel()
    
    @State var isAlert:Bool = false
    @State var isDeleteAlert:Bool = false
    
    var body: some View {
        Button {
            isAlert = true
        } label: {
            VStack{
                Image(systemName:"folder.badge.minus")
                    .font(.system(size: 40))
                    .frame(height: 40)
                Text("All Delete")
            }
        }.alert("登録している\nすべての旅行の記録を\n削除しますか？", isPresented: $isAlert) {
                Button(role:.destructive) {
                    dbControl.deleteRealmAllTable()
                    isDeleteAlert = true
                } label: {
                    Text("削除")
                }
            }.alert("削除しました。", isPresented: $isDeleteAlert) {
                
            }
    }
}
