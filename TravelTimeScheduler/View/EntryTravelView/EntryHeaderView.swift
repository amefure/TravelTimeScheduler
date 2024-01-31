//
//  EntryHeaderView.swift
//  TravelTimeScheduler
//
//  Created by t&a on 2023/05/10.
//

import SwiftUI

struct EntryHeaderView: View {
    
    // MARK: - ViewModels
    private let validationUtility = ValidationUtility()
    private let dbControl = SwitchingDatabaseControlViewModel()
    @ObservedObject var allTravelFirebase = FBDatabaseTravelListViewModel.shared
    
    private let viewModel = EntryTravelViewModel()
    
    // MARK: - TextField
    public let travelName: String        // 旅行名
    public let memberArray: [String]     // メンバー
    public let startDate: Date           // 出発日
    public let endDate: Date             // 帰宅日
    public let image: UIImage?            // 画像
    
    // MARK: - Parameters
    public let travel:Travel?
    
    // MARK: - View
    @State private var isAlert: Bool = false
    
    var startInterstitial: () -> Void
    
    private func validatuonInput() -> Bool{
        validationUtility.validateEmpty(str:travelName)
    }
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        
        HStack{
            
            Button {
                dismiss()
            } label: {
                Label("戻る", systemImage: "chevron.backward")
            }.foregroundColor(Color.foundation)
                .fontWeight(.bold)
            
            
            Spacer()
            
            HeaderTitleView(title: "旅行登録")
            
            Spacer()
            
            Button(action: {
                if validatuonInput() {
                    
                    if let travel = travel {
                        // 更新処理
                        dbControl.updateTravel(
                            id: travel.id.stringValue,
                            travelName: travelName,
                            members: memberArray,
                            startDate: startDate,
                            endDate: endDate,
                            schedules: travel.schedules)
                        
                        if let image = image {
                            viewModel.uploadImgFile(fileName: travel.id.stringValue, image: image)
                        }
                        
                    } else {
                        // 新規登録処理
                        let id = dbControl.createTravel(
                            travelName: travelName,
                            members: memberArray,
                            startDate: startDate,
                            endDate: endDate)
                        if let image = image {
                            viewModel.uploadImgFile(fileName: id, image: image)
                        }
                    }
                    
                    isAlert = true
                }
                
            }, label: {
                Text(travel == nil ? "登録" : "更新")
            }).padding()
                .foregroundColor(validatuonInput() ? .accentSchedule : .gray)
                .fontWeight(.bold)
        }.padding(10)
            .background(Color.thema)
            .alert(travel == nil ? "「\(travelName)」を登録しました。" : "「\(travelName)」を更新しました。", isPresented: $isAlert) {
                Button {
                    // 広告の再生
                    startInterstitial()
                    dismiss()
                } label: {
                    Text("OK")
                }
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
