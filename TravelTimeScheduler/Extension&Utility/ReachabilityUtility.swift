//
//  ReachabilityUtility.swift
//  TravelTimeScheduler
//
//  Created by t&a on 2024/02/01.
//

import UIKit
import Reachability

class ReachabilityUtility {
    
    public var isAvailable: Bool {
        do {
            let reachability = try Reachability()
            switch reachability.connection {
            case .wifi:
                return true
            case .cellular:
                return true
            case .unavailable:
                return false
            case .none:
                return false
            }
        } catch {
            print("Reachabilityインスタンス生成失敗")
            return false
        }
    }
}
