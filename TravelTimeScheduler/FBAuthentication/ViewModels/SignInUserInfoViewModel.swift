//
//  SignInUserViewModel.swift
//  TravelTimeScheduler
//
//  Created by t&a on 2023/04/07.
//

import UIKit
import RealmSwift

class SignInUserInfoViewModel {
    
    private let userDefaults: UserDefaultsProtocol

    init(userDefaults: UserDefaultsProtocol = UserDefaultsWrapper.shared) {
        self.userDefaults = userDefaults
    }
    
    var signInUserId: String {
        get {
            return userDefaults.object(forKey: "SignInUserId") as? String ?? "none"
        }
        set {
            userDefaults.set(newValue, forKey: "SignInUserId")
        }
    }
    
    var signInUserName: String {
        get {
            return userDefaults.object(forKey: "SignInUserName") as? String ?? "User"
        }
        set {
            userDefaults.set(newValue, forKey: "SignInUserName")
        }
    }
    
    var signInUserProvider: String {
        get {
            return userDefaults.object(forKey: "SignInUserProvider") as? String ?? "none"
        }
        set {
            userDefaults.set(newValue, forKey: "SignInUserProvider")
        }
    }
    
    var signInUserEmail: String {
        get {
            if let email = userDefaults.object(forKey: "SignInUserEmail") as? String{
                if email.contains("appleid.com") {
                    return "非公開"
                }
                return email
            }else{
                return "none"
            }
        }
        set {
            userDefaults.set(newValue, forKey: "SignInUserEmail")
        }
    }
    
}

//MARK: - AuthViewModelから呼び出し
extension SignInUserInfoViewModel {
    
    private func setSignInProvider(provider:AuthProviderModel){
        switch provider{
            
        case .email:
            self.signInUserProvider = AuthProviderModel.email.rawValue
        case .apple:
            self.signInUserProvider = AuthProviderModel.apple.rawValue
        case .google:
            self.signInUserProvider = AuthProviderModel.google.rawValue
        }
    }
    
    public func getSignInProvider() -> AuthProviderModel{
        switch self.signInUserProvider {
        case AuthProviderModel.email.rawValue:
            return AuthProviderModel.email
        case AuthProviderModel.apple.rawValue:
            return AuthProviderModel.apple
        case AuthProviderModel.google.rawValue:
            return AuthProviderModel.google
        default:
            return AuthProviderModel.email
        }
    }
}

//MARK: - AuthViewModelから呼び出し
extension SignInUserInfoViewModel {

    // サインインした際に実行される処理
    public func setCurrentUserInfo(uid:String,name:String,email:String,provider:AuthProviderModel){
        signInUserId = uid
        signInUserName = name
        setSignInProvider(provider: provider)
        signInUserEmail = email
    }
    
    // サインアウトした際に実行される処理
    public func resetUserInfo(){
        signInUserId = ""
        signInUserName = "MyName"
        signInUserProvider = ""
    }
}
