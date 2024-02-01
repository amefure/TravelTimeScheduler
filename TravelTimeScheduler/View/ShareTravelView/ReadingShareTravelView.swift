//
//  ReadingShareTravelView.swift
//  TravelTimeScheduler
//
//  Created by t&a on 2023/05/29.
//

import SwiftUI

struct ReadingShareTravelView: View {
    
    // MARK: - ViewModels
    private let validationVM = ValidationUtility()
    @ObservedObject var allTravelFirebase = FBDatabaseTravelListViewModel.shared
    @ObservedObject var interstitial = AdmobInterstitialView()
    private let dbControl = SwitchingDatabaseControlViewModel()
    private let userInfoVM = SignInUserInfoViewModel()
    
    @State var travelId:String = ""
    @State var isClick:Bool = false
    @State var isPresented:Bool = false
    @State var isSuccess:Bool = false
    
    @Environment(\.dismiss) var dismiss
    
    private func validationCheck() -> Bool{
        if let travel = allTravelFirebase.travels.first(where: { $0.id.stringValue == travelId}){
            // readableUserlId配列の中にUserIdがなければOK
            if travel.readableUserlId.contains(userInfoVM.signInUserId) == false {
                return true
            }
        }
        return false
    }
    //
    var body: some View {
        VStack(spacing:0) {
            
            HeaderView(
                title: "Travelを共有する",
                leadingIcon: "chevron.backward",
                leadingAction: {
                    dismiss()
                })
            
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
                                dbControl.updateTravelReadableUserId(userId: userInfoVM.signInUserId, travelId: travelId)
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
                    }.frame(maxWidth: DeviceSizeManager.deviceWidth - 20, alignment: .center)
                        .listRowBackground(Color.thema)
                }
            }
        }.navigationBarBackButtonHidden(true)
            .alert(isSuccess ? "旅行情報を追加しました。" : "存在しないID\nまたは\n既に追加済みのIDです。", isPresented: $isPresented) {
                Button {
                    if isSuccess {
                        interstitial.presentInterstitial()
                        dismiss()
                    }
                } label: {
                    Text("OK")
                }
            }
            .onAppear {
                interstitial.loadInterstitial()
            }
            .onDisappear {
                if AuthViewModel.shared.isSignIn {
                    dbControl.readAllTravel { data in
                        allTravelFirebase.travels = data
                    }
                }
            }
    }
}
