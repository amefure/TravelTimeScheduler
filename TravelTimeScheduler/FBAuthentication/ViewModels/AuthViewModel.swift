//
//  AuthManager.swift
//  TravelTimeScheduler
//
//  Created by t&a on 2023/03/31.
//

import UIKit
import FirebaseAuth
import FirebaseCore
import AuthenticationServices // Apple

class AuthViewModel:ObservableObject {
    
    // MARK: - シングルトン
    static let shared = AuthViewModel()
    
    // UserDefaultVM
    private let userInfoVM = SignInUserInfoViewModel.shared
    
    // AuthModel
    private var auth = AuthModel.shared
    private let emailAuth = EmailAuthModel.shared
    private let googleAuth = GoogleAuthModel.shared
    private let appleAuth = AppleAuthModel.shared
    
    private let errModel = AuthErrorModel()
    
    // プロパティ
    @Published var errMessage:String = ""
    
    private func switchResultAndSetErrorMsg(_ result:Result<Bool,Error>) -> Bool{
        switch result {
        case .success(_) :
            return true
        case .failure(let error) :
            print(error.localizedDescription)
            self.errMessage = self.errModel.setErrorMessage(error)
            return false
        }
    }
    
    public func resetErrorMsg(){
        self.errMessage = ""
    }
    
    private func setCurrentUserInfo(provider:AuthProviderModel){
        userInfoVM.signInUserId = auth.getCurrentUser()!.uid
        userInfoVM.signInUserName = auth.getCurrentUser()?.displayName ?? auth.defaultName
        userInfoVM.setSignInProvider(provider: provider)
        userInfoVM.signInUserEmail = auth.getCurrentUser()?.email ?? ""
    }
    
    // MARK: - カレントユーザー取得
    public func getCurrentUser() -> User? {
        return self.auth.getCurrentUser()
    }
    
    /// サインアウト
    public func signOut(completion: @escaping (Bool) -> Void ) {
        self.auth.SignOut { result in
            if self.switchResultAndSetErrorMsg(result) {
                self.userInfoVM.resetUserInfo() // ユーザー情報をリセット
                completion(true)
            }else{
                completion(false)
            }
        }
    }
    
    /// 退会
    public func withdrawal(completion: @escaping (Bool) -> Void ) {
        self.auth.withdrawal { result in
            completion(self.switchResultAndSetErrorMsg(result))
        }
    }
    
    /// ユーザー情報編集
    public func editUserName(name:String,completion: @escaping (Bool) -> Void ) {
        self.auth.editUserName(name: name){ result in
            self.setCurrentUserInfo(provider: self.userInfoVM.getSignInProvider() )
            completion(self.switchResultAndSetErrorMsg(result))
        }
    }

}

// MARK: - Email
extension AuthViewModel {
    
    /// サインイン
    public func emailSignIn(email:String,password:String,completion: @escaping (Bool) -> Void ) {
        emailAuth.signIn(email: email, password: password) { result in
            if self.switchResultAndSetErrorMsg(result) {
                self.setCurrentUserInfo(provider: .email)
                completion(true)
            }else{
                completion(false)
            }
        }
    }
    
    /// 新規登録
    public func createEmailUser(email:String,password:String,name:String,completion: @escaping (Bool) -> Void ) {
        emailAuth.createUser(email: email, password: password, name: name) { result in
            if self.switchResultAndSetErrorMsg(result) {
                self.setCurrentUserInfo(provider: .email)
                completion(true)
            }else{
                completion(false)
            }
        }
    }
    
    /// 再認証→退会
    public func credentialEmailWithdrawal(password:String,completion: @escaping (Bool) -> Void ) {
        emailAuth.reAuthUser(pass: password) { result in
            if self.switchResultAndSetErrorMsg(result) {
                self.withdrawal { result in
                    completion(result)
                }
            }
        }
    }
    
    /// リセットパスワード
    public func resetPassWord(email:String,completion: @escaping (Bool) -> Void ) {
        emailAuth.resetPassWord(email: email) { result in
            completion(self.switchResultAndSetErrorMsg(result))
        }
    }
}

// MARK: - Google
extension AuthViewModel {
    
    /// サインイン
    public func credentialGoogleSignIn(completion: @escaping (Bool) -> Void ) {
        googleAuth.getCredential { credential in
            if credential != nil {
                self.auth.credentialSignIn(credential: credential!) { result in
                    if self.switchResultAndSetErrorMsg(result) {
                        self.setCurrentUserInfo(provider: .google)
                        completion(true)
                    }else{
                        completion(false)
                    }
                }
            }
        }
    }
    
    /// 再認証→退会
    public func credentialGoogleWithdrawal(completion: @escaping (Bool) -> Void ) {
        self.credentialGoogleReAuth { result in
            if result {
                self.withdrawal { result in
                    completion(result)
                }
            }
        }
    }
    
    /// 再認証
    private func credentialGoogleReAuth(completion: @escaping (Bool) -> Void ) {
        googleAuth.getCredential { credential in
            if credential != nil {
                self.googleAuth.reAuthUser(user: self.auth.getCurrentUser()!, credential: credential!) { result in
                    completion(self.switchResultAndSetErrorMsg(result))
                }
            }
        }
    }
}

// MARK: - Apple
extension AuthViewModel {
    
    ///  サインイン
    public func credentialAppleSignIn(credential:AuthCredential,completion: @escaping (Bool) -> Void ) {
        self.auth.credentialSignIn(credential: credential) { result in
            
            if self.switchResultAndSetErrorMsg(result) {
                self.setCurrentUserInfo(provider: .apple)
                completion(true)
            }else{
                completion(false)
            }
        }
    }
    
    /// Firebase
    public func getHashAndSetCurrentNonce() -> String {
        let nonce = appleAuth.randomNonceString()
        appleAuth.currentNonce = nonce
        return appleAuth.sha256(nonce)
    }
    
    /// ボタンクリック後の結果分岐処理
    public func switchAuthResult(result:Result<ASAuthorization, Error>) -> AuthCredential?{
        return appleAuth.switchAuthResult(result: result)
    }

}

