//
//  ValidationManager.swift
//  TravelTimeScheduler
//
//  Created by t&a on 2023/03/31.
//

import SwiftUI

// MARK: - 入力値バリデーション管理クラス
class ValidationUtility {
    
    // MARK: - Empty
    public func validateEmpty(str: String) -> Bool {
        if str.isEmpty {
            return false
        }
        return true
    }
    
    // MARK: - Email
    public func validateEmail(email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: email)
    }
  
    // MARK: - PassWord
    public func validatePassWord(password: String) -> Bool {
        if password.count >= 8 {
            return true
        }
        return false
    }
}
