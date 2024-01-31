//
//  EntryTravelView.swift
//  TravelTimeScheduler
//
//  Created by t&a on 2023/04/13.
//

import SwiftUI
import RealmSwift

struct EntryTravelView: View {
    
    // MARK: - ViewModels
    private let userInfoVM = SignInUserInfoViewModel()
    private let viewModel = EntryTravelViewModel()
    
    // MARK: - TextField
    @State private var travelName = ""      // 旅行名
    @State private var memberArray = [""] // メンバー
    @State private var startDate = Date()     // 出発日
    @State private var endDate = Date()       // 帰宅日
    
    @State private var image: UIImage?
    @State private var isShowImagePicker = false
    
    @ObservedObject private var interstitial = AdmobInterstitialView()
    
    // MARK: - Parameters
    public let travel: Travel?
    public var parentDismissFunction: () -> Void
    
    // DeleteTravelButtonクリック時に画面をトップに戻す
    @Environment(\.dismiss) var dismiss
    
    private func backRootViewFunction() {
        self.dismiss()
        self.parentDismissFunction()
    }
    
   
    
    var body: some View {
        
        // MARK: - Header
        EntryHeaderView(
            travelName: travelName,
            memberArray: memberArray,
            startDate: startDate,
            endDate: endDate,
            image: image,
            travel: travel,
            startInterstitial: {
                interstitial.presentInterstitial()
            })
        
        // MARK: - Contents
        List {
            
            ZStack {
                if let image = image {
                    Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: DeviceSizeManager.deviceWidth, height: 100)
                            .clipped()
                } else {
                    Image("Walking_outside")
                        .resizable()
                        .scaledToFit()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: DeviceSizeManager.deviceWidth - 40, height: 100)
                        .clipped()
                }
                
                Button {
                    isShowImagePicker = true
                } label: {
                    Image(systemName: "plus")
                        .frame(width: DeviceSizeManager.deviceWidth, height: 100)
                        .background(Color.opacityGray)
                        .foregroundStyle(Color.thema)
                }
            }
            
            Section("Travel Name") {
                TextField("旅行名", text: $travelName)
                    .padding()
                    .background(Color.foundation)
                    .cornerRadius(5)
            }.listRowSeparator(.hidden)
            
            
            Section("Member") {
                InputMemberView(memberArray: $memberArray)
            } .listRowSeparator(.hidden)
            
            Section("Travel Period"){
                InputPeriodView(startDate: $startDate, endDate: $endDate)
            }.listRowSeparator(.hidden)
            
            
            if travel != nil {
                /// 編集モードならDeleteボタン
                Section("Setting"){
                    HStack{
                        Spacer()
                        DeleteTravelButtonView(travel: travel!, parentBackRootViewFunction: backRootViewFunction)
                            .foregroundColor(.negative)
                        Spacer()
                    }
                }.listRowSeparator(.hidden)
            }
        }
        .sheet(isPresented: $isShowImagePicker) {
            ImagePickerDialog(image: $image)
        }
        .fontWeight(.bold)
        .listStyle(GroupedListStyle())
        .scrollContentBackground(.hidden)
        .navigationCustomBackground()
        .onAppear{
            /// 　初期値セット
            if let travel = travel {
                travelName = travel.name
                memberArray = Array(travel.members)
                startDate = travel.startDate
                endDate = travel.endDate
                viewModel.downloadImage(fileName: travel.id.stringValue) { image in
                    self.image = image
                }
            } else {
                let myName = userInfoVM.signInUserName
                memberArray = [myName]
            }
            interstitial.loadInterstitial()
            
            
        }.navigationBarBackButtonHidden(true)
    }
}
