//
//  EmailAuthButtonView.swift
//  TravelTimeScheduler
//
//  Created by t&a on 2023/04/06.
//

import SwiftUI
import RealmSwift

struct EmailAuthButtonView: View {

    // MARK: - ViewModels
    @ObservedObject var authVM = AuthViewModel.shared
    private let validationVM = ValidationViewModel()
    
    // MARK: - Navigationプロパティ
    @Binding var isActive:Bool
    
    // MARK: - Inputプロパティ
    var name:String?        // ログインView呼び出し時はnil
    var email:String
    var password:String
    
    // MARK: - プロパティ
    @State var isClick:Bool = false // ログインボタンを押されたかどうか
    
    // MARK: - バリデーション
    func validationInput()-> Bool{
        if name != nil{
            if validationVM.validateEmpty(str: name!) && validationVM.validateEmail(email: email) && validationVM.validatePassWord(password: password) {
                return true
            }
        }else{
            if validationVM.validateEmail(email: email) && validationVM.validatePassWord(password: password) {
                return true
            }
        }
        return false
    }
    
    
    var body: some View {
        // MARK: - ボタン
        ProgressButtonStack(isClick: $isClick) {
            // ログインボタン
            Button(action: {
                if validationInput(){
                    isClick = true // 処理中にする
                    if name != nil{
                        // 新規登録
                        authVM.createEmailUser(email: email, password: password,name: name!) { result in
                            if result {
                                
                                authVM.resetErrorMsg()
                                // 新規登録時にRealmのデータをFirebaseにコピーする処理
                                UserNewEntryRegistrationFBDatabaseViewModel().register()
                                isActive = true  // 画面遷移
                            }else{
                                isClick = false  // 解除
                            }
                        }
                    }else{
                        // SignIn
                        authVM.emailSignIn(email: email, password: password) { result in
                            if result {
                                authVM.resetErrorMsg()
                                isActive = true  // 画面遷移
                            }else{
                                isClick = false  // 解除
                            }
                        }
                    }
                }
            }, label: {
                Text(name != nil ? "新規登録" : "ログイン")
                    .frame(width:200,height: 40)
                    .background((validationInput() ? Color.thema : .gray))
                    .foregroundColor(.white)
                    .shadowCornerRadius()
                    .disabled(!validationInput())
            })
        }
        
    }
}
