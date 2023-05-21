//
//  SwitchDBStatusViewModel.swift
//  TravelTimeScheduler
//
//  Created by t&a on 2023/05/18.
//

import SwiftUI

/// DBどちらのタブがアクティブになっているかの状態を保持するクラス
class SwitchDBStatusViewModel: ObservableObject {
    
    /// シングルトンで全ビューで共有させる
    static let shared = SwitchDBStatusViewModel()

    /// Firebaseならtrue /Relamならfalse
    @Published var isFB = false

}
