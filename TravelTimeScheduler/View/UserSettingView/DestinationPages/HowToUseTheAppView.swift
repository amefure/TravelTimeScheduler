//
//  HowToUseTheAppView.swift
//  TravelTimeScheduler
//
//  Created by t&a on 2023/06/09.
//

import SwiftUI

struct HowToUseTheAppView: View {
    @Environment(\.dismiss) var dismiss
    var body: some View {
        
        VStack {
            
            HeaderView(
                title: "旅Timeの使い方",
                leadingIcon: "chevron.backward",
                leadingAction: { dismiss() })
            
            List {
                
                Section("Question"){
                    
                    AccordionBoxView(question: "登録できる旅行の数はいくつですか？", answer: "登録できる「旅行」の数は今のところ無制限です。\nしかしこちらの都合により制限を設ける可能性もあります。")
                    
                    AccordionBoxView(question: "サインインしていない時に登録した「旅行」はどうなりますか？", answer: "サインイン前に登録していたデータは新規アカウント作成時に自動で引き継がれます。")
                    
                    AccordionBoxView(question: "友達と共有するためにはどうしたら良いですか？", answer: "友達と共有するためには以下の2STEPを実行してください。\n※またそのためにはアカウントを作成しサインインする必要があります。\n\n・STEP1：旅行IDのコピー\n  -旅行IDは「旅行」＞「共有」から確認できるので友達に教えてもらってください。\n\n・STEP2：Topページ上部からIDを貼り付けて「決定」を押す")
                    
                    AccordionBoxView(question: "共有している「旅行」を削除した場合どうなりますか？", answer: "友達と共有している「旅行」を削除した場合は自身の共有権限がなくなるのみで友達側にはデータが残ります。\nしかし友達側も削除し、誰も読み取る可能性の無いデータは自動で削除されるのでご注意ください。")
                    
                    AccordionBoxView(question: "○○な機能を追加してほしい", answer: "アプリのレビューもしくは「利用規約」のWebサイトのお問い合わせフォームからフィードバックをいただけるとできる限り対処いたします。\nしかしご要望に添えない可能性があることをご了承ください。")
                }
                
            }
        }.background(Color.list)
            .navigationBarBackButtonHidden(true)
            .fontWeight(.bold)
    }
}
