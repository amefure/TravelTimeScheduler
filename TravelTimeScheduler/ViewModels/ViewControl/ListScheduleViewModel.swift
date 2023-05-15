//
//  ListViewModel.swift
//  TravelTimeScheduler
//
//  Created by t&a on 2023/04/23.
//

import UIKit

class ListScheduleViewModel: ObservableObject {

    static let shared = ListScheduleViewModel()

    @Published var isDeleteMode = false
    
    func toggleDeleteMode() {
        isDeleteMode.toggle()
    }

}
