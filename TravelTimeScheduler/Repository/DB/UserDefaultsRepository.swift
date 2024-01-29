//
//  UserDefaultsRepository.swift
//  TravelTimeScheduler
//
//  Created by t&a on 2024/01/23.
//

import UIKit

class UserDefaultsKey {
    
    static let SIGNIN_USER_ID = "SignInUserId"
    static let SIGNIN_USER_NAME = "SignInUserName"
    static let SIGNIN_USER_PROVIDER = "SignInUserProvider"
    static let SIGNIN_USER_EMAIL = "SignInUserEmail"
}

/// UserDefaultsの基底クラス
class UserDefaultsRepository {
    static let sheard = UserDefaultsRepository()

    private let userDefaults = UserDefaults.standard

    /// Bool：保存
    public func setBoolData(key: String, isOn: Bool) {
        userDefaults.set(isOn, forKey: key)
    }

    /// Bool：取得
    public func getBoolData(key: String) -> Bool {
        return userDefaults.bool(forKey: key)
    }

    /// Int：保存
    public func setIntData(key: String, value: Int) {
        userDefaults.set(value, forKey: key)
    }

    /// Int：取得
    public func getIntData(key: String) -> Int {
        return userDefaults.integer(forKey: key)
    }

    /// String：保存
    public func setStringData(key: String, value: String) {
        userDefaults.set(value, forKey: key)
    }

    /// String：取得
    public func getStringData(key: String, initialValue: String = "") -> String {
        return userDefaults.string(forKey: key) ?? initialValue
    }
}


