//
//  ContentView.swift
//  TravelTimeScheduler
//
//  Created by t&a on 2023/03/31.
//

import SwiftUI
import RealmSwift

struct ListTravelView: View {
    
    // MARK: - ViewModels
    public let filteringResults:Results<Travel>
    
    var body: some View {
        List(filteringResults){ travel in
            RowTravelView(travel: travel)
        }.listStyle(GroupedListStyle())
    }
}

struct FBListTravelView: View {

    
    // MARK: - ViewModels
    public let filteringResults:Array<Travel>
    
    var body: some View {
        List(filteringResults){ travel in
            RowTravelView(travel: travel)
        }.listStyle(GroupedListStyle())
    }
}
