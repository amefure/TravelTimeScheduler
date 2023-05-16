//
//  AuthModel.swift
//  TravelTimeScheduler
//
//  Created by t&a on 2023/04/05.
//

import UIKit
import FirebaseAuth
import FirebaseCore
import AuthenticationServices

class AuthModel {

    // MARK: - シングルトン
    static let shared = AuthModel()
    
    // MARK: - リファレンス
    private let auth = Auth.auth()

    
    // MARK: -
    public func getCurrentUser() -> User? {
        return auth.currentUser
    }
    
    public let defaultName = "自分(名前未設定)"
    
    // MARK: - Sign In for Credential
    public func credentialSignIn(credential: AuthCredential,completion : @escaping (Result<Bool, Error>) ->  Void ){
        self.auth.signIn(with: credential) { (authResult, error) in
            if error == nil {
            if authResult?.user != nil{
                completion(.success(true))
            }
            }else{
                completion(.failure(error!))
            }
        }
    }
    
    // MARK: - サインアウト処理
    public func SignOut(completion : @escaping (Result<Bool, Error>) ->  Void ){
        do{
            try auth.signOut()
#if DEBUG
            print("SignOut")
#endif
            completion(.success(true))
        } catch let signOutError as NSError {
            completion(.failure(signOutError))
        }
    }
    
    // MARK: -  各プロバイダ退会処理 & Appleアカウントは直呼び出し
    public func withdrawal(completion : @escaping (Result<Bool, Error>) ->  Void ){
        if let user = auth.currentUser {
            user.delete { error in
                if error == nil {
#if DEBUG
                    print("退会成功")
#endif
                    completion(.success(true))
                } else {
#if DEBUG
                    print("退会失敗")
#endif
                    completion(.failure(error!))
                }
            }
        }
    }
    
    
    // MARK: - ユーザー情報編集
    public func editUserName(name:String,completion : @escaping (Result<Bool, Error>) ->  Void ){
        if let user = auth.currentUser {
            let request = user.createProfileChangeRequest()
            request.displayName = name
            request.commitChanges { error in
                if error == nil{
                    completion(.success(true))
                }else{
                    completion(.failure(error!))
                }
            }
        }else{
            completion(.failure(AuthErrorCode.userNotFound as! any Error))
        }
    }
}


