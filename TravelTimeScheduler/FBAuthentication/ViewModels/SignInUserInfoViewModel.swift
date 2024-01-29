//
//  SignInUserViewModel.swift
//  TravelTimeScheduler
//
//  Created by t&a on 2023/04/07.
//

import UIKit
import RealmSwift

class SignInUserInfoViewModel {
    
    private let userDefaultsRepository: UserDefaultsRepository
    
    init(repositoryDependency: RepositoryDependency = RepositoryDependency()) {
        userDefaultsRepository = repositoryDependency.userDefaultsRepository
    }
    
    var signInUserId: String {
        get {
            return userDefaultsRepository.getStringData(key: UserDefaultsKey.SIGNIN_USER_ID, initialValue: "none")
        }
        set {
            userDefaultsRepository.setStringData(key: UserDefaultsKey.SIGNIN_USER_ID, value: newValue)
        }
    }
    
    var signInUserName: String {
        get {
            return userDefaultsRepository.getStringData(key: UserDefaultsKey.SIGNIN_USER_NAME, initialValue: "User")
        }
        set {
            userDefaultsRepository.setStringData(key: UserDefaultsKey.SIGNIN_USER_NAME, value: newValue)
        }
    }
    
    var signInUserProvider: String {
        get {
            return userDefaultsRepository.getStringData(key: UserDefaultsKey.SIGNIN_USER_PROVIDER, initialValue: "none")
        }
        set {
            userDefaultsRepository.setStringData(key: UserDefaultsKey.SIGNIN_USER_PROVIDER, value: newValue)
        }
    }
    
    var signInUserEmail: String {
        get {
            let email = userDefaultsRepository.getStringData(key: UserDefaultsKey.SIGNIN_USER_EMAIL, initialValue: "none")
            if email.contains("appleid.com") {
                return "非公開"
            } else {
                return email
            }
        }
        set {
            userDefaultsRepository.setStringData(key: UserDefaultsKey.SIGNIN_USER_EMAIL, value: newValue)
        }
    }
}

//MARK: - AuthViewModelから呼び出し
extension SignInUserInfoViewModel {
    
    private func setSignInProvider(provider: AuthProviderModel) {
        switch provider{
            
        case .email:
            self.signInUserProvider = AuthProviderModel.email.rawValue
        case .apple:
            self.signInUserProvider = AuthProviderModel.apple.rawValue
        case .google:
            self.signInUserProvider = AuthProviderModel.google.rawValue
        }
    }
    
    public func getSignInProvider() -> AuthProviderModel {
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
    public func setCurrentUserInfo(uid: String, name: String, email: String, provider: AuthProviderModel){
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
