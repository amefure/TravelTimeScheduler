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
    private let userInfoVM = SignInUserInfoViewModel()
    
    // AuthModel
    private var auth = AuthModel.shared
    private let emailAuth = EmailAuthModel.shared
    private let googleAuth = GoogleAuthModel.shared
    private let appleAuth = AppleAuthModel.shared
    
    private let errModel = AuthErrorModel()
    
    // プロパティ
    @Published var errMessage:String = ""
    
    /// Auth処理の結果に応じた真偽値とエラーメッセージのセット
    private func switchResultAndSetErrorMsg(_ result:Result<Bool,Error>) -> Bool{
        switch result {
        case .success(_) :
            return true
        case .failure(let error) :
#if DEBUG
            print(error.localizedDescription)
#endif
            self.errMessage = self.errModel.setErrorMessage(error)
            return false
        }
    }
    
    /// 観測されているエラーメッセージプロパティのリセット
    public func resetErrorMsg(){
        self.errMessage = ""
    }
    
    /// サインイン時にUser情報をデバイスに格納する
    private func setCurrentUserInfo(provider:AuthProviderModel){
        let uid = auth.getCurrentUser()!.uid
        let name = auth.getCurrentUser()?.displayName ?? auth.defaultName
        let email = auth.getCurrentUser()?.email ?? ""
        userInfoVM.setCurrentUserInfo(uid: uid, name: name, email: email,provider: provider)
    }
    
    // MARK: - カレントユーザー取得
    public func getCurrentUser() -> User? {
        return self.auth.getCurrentUser()
    }
    
    // MARK: - サインインしているかどうか
    public var isSignIn:Bool {
        if  self.getCurrentUser() != nil {
            return true
        }else{
            return false
        }
    }
    
    /// サインアウト
    public func signOut(completion: @escaping (Bool) -> Void ) {
        self.auth.SignOut { result in
            if self.switchResultAndSetErrorMsg(result) {
                completion(true)
            }else{
                completion(false)
            }
        }
    }
    
    /// 退会 & Appleアカウントは直呼び出し
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
    public func credentialEmailReAuthUser(password:String,completion: @escaping (Bool) -> Void ) {
        emailAuth.reAuthUser(pass: password) { result in
            if self.switchResultAndSetErrorMsg(result) {
               completion(true)
            }else{
                completion(false)
            }
        }
    }
    
    /// メール再設定
    public func updateEmail(email:String,password:String,completion:@escaping (Bool) -> Void ) {
        emailAuth.reAuthUser(pass: password) { result in
            if self.switchResultAndSetErrorMsg(result) {
                self.emailAuth.updateEmail(email: email) { result in
                    if self.switchResultAndSetErrorMsg(result) {
                        self.setCurrentUserInfo(provider: .email)
                        completion(true)
                    }else{
                        completion(false)
                    }
                }
            }else{
                completion(false)
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
    /// 再認証
    public func credentialGoogleReAuth(completion: @escaping (Bool) -> Void ) {
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

