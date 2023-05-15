//
//  ValidationManager.swift
//  TravelTimeScheduler
//
//  Created by t&a on 2023/03/31.
//

import SwiftUI

// MARK: - 入力値バリデーション管理クラス
class ValidationViewModel {
    
    // MARK: - Empty
    public func validateEmpty(str: String) -> Bool {
        if str != ""{
            return true
        }
        return false
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

extension ValidationViewModel {
    public func checkNegativeAmount (_ amount:Int) -> Bool{
        if amount <= -1  {
            return false
        }else{
            return true
        }
    }
        
    public func checkNonEmptyText(_ text:String) -> Bool{
        if text.isEmpty {
            return false
        }else{
            return true
        }
    }
    
    public func checkValidURL (_ urlStr: String) -> Bool {
        guard let encurl = urlStr.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed) else {
            return false
        }
        if let url = NSURL(string: encurl) {
            return UIApplication.shared.canOpenURL(url as URL)
        }else{
            return false
        }
    }
    
}
