//
//  DeleteTravelButtonView.swift
//  TravelTimeScheduler
//
//  Created by t&a on 2023/04/28.
//

import SwiftUI

struct DeleteTravelButtonView: View {
    
    // MARK: - ViewModels
    private let realmDataBase = SwitchingDatabaseControlViewModel.shared
    
    // MARK: - Parameters
    public let travel:Travel
    public var parentBackRootViewFunction: () -> Void
    
    @State var isDeleteAlert = false
    
    var body: some View {
        Button (role:.destructive){
            isDeleteAlert = true
        } label: {
            Text("旅行削除")
        }.alert("「\(travel.name)」の記録と思い出をすべて削除しますか...？", isPresented: $isDeleteAlert) {
            Button(role:.destructive) {
                realmDataBase.deleteTravel(id: travel.id.stringValue)
                self.parentBackRootViewFunction()
            } label: {
                Text("削除")
            }
        }
    }
}
