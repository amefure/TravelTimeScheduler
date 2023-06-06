//
//  ReadingShareTravelView.swift
//  TravelTimeScheduler
//
//  Created by t&a on 2023/05/29.
//

import SwiftUI

struct ReadingShareTravelView: View {
    
    // MARK: - ViewModels
    private let validationVM = ValidationViewModel()
    @ObservedObject var allTravelFirebase = FBDatabaseTravelListViewModel.shared
    private let dbControl = SwitchingDatabaseControlViewModel.shared
    private let signInUserInfo = SignInUserInfoViewModel()
    private let deviceSize = DeviceSizeViewModel()
    
    @State var travelId:String = ""
    @State var isClick:Bool = false
    @State var isPresented:Bool = false
    @State var isSuccess:Bool = false
    
    @Environment(\.dismiss) var dismiss
    
    
    private func validationCheck() -> Bool{
        if let travel = allTravelFirebase.travels.first(where: { $0.id.stringValue == travelId}){
            // readableUserlId配列の中にUserIdがなければOK
            if travel.readableUserlId.contains(signInUserInfo.signInUserId) == false {
                return true
            }
        }
        return false
    }
    //
    var body: some View {
        VStack(spacing:0){
            
            HeaderTitleView(title:"ReadingShareTravel")
                .frame(width: deviceSize.deviceWidth)
                .padding()
                .background(Color.thema)
            
            List{
                
                // MARK: - ImageView
                SectionImageView(image: "Cloud")
                
                Section(header: Text("TravelId入力欄"),footer: Text("・共有して管理する旅行のID(英数字の羅列)を入力してください。\n・旅行のIDは「旅行」＞「共有」から確認できます。")){
                    TextField("例：647465d2cf72201fc19f38fa", text: $travelId)
                }
                
                Section{
                    ProgressButtonStack(isClick: $isClick) {
                        Button {
                            isClick = true
                            
                            if validationCheck() {
                                dbControl.updateTravelReadableUserId(userId: signInUserInfo.signInUserId, travelId: travelId)
                                isSuccess = true
                            }else{
                                isSuccess = false
                            }
                            
                            let mainQ = DispatchQueue.main
                            mainQ.asyncAfter ( deadline: DispatchTime.now() + 1) {
                                isClick = false
                                isPresented = true
                            }
                            
                            
                        } label: {
                            Text("決定")
                                .tint(.white)
                                .fontWeight(.bold)
                        }.disabled(!validationVM.validateEmpty(str:travelId))
                    }.listRowBackground(Color.thema)
                        .frame(maxWidth:.infinity, alignment: .center)
                        .alert(isSuccess ? "旅行情報を追加しました。" : "存在しないID\nもしくは\n既に追加済みのIDです。", isPresented: $isPresented) {
                            Button {
                                if isSuccess {
                                    dismiss()
                                }
                            } label: {
                                Text("OK")
                            }
                        }
                }
            }
        }.onDisappear {
            if AuthViewModel.shared.isSignIn {
                dbControl.readAllTravel { data in
                    allTravelFirebase.travels = data
                }
            }
        }
    }
}
