//
//  ListScheduleView.swift
//  TravelTimeScheduler
//
//  Created by t&a on 2023/04/15.
//

import SwiftUI
import RealmSwift
import Combine

struct ListScheduleView: View {
    
    // MARK: - ViewModels
    private let displayDate = DisplayDateViewModel()
    @ObservedObject var switchDBViewModel = CurrentDatabaseStatusViewModel.shared
  
    // MARK: - Parameters
    public let travel:Travel // Realm.Result or Array
    public let dateTime:Date
    
    // MARK: - スケジュール表示用
    var filteringTravelSchedule: Results<Schedule>? {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: dateTime)
        let tomorrow = calendar.date(byAdding: .day, value: 1, to: today)!
        if switchDBViewModel.isFB {
            return nil
        }else{
            return travel.schedules.filter("dateTime >= %@ AND dateTime < %@", today, tomorrow).sorted(byKeyPath: "dateTime")
        }
    }
    
    // MARK: - スケジュール表示用
    var filteringTravelScheduleArray: Array<Schedule> {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: dateTime)
        let tomorrow = calendar.date(byAdding: .day, value: 1, to: today)!
        let array = Array(travel.schedules)
        
        return array.filter(({ $0.dateTime >= today && $0.dateTime < tomorrow})).sorted(by:{ $0.dateTime < $1.dateTime })
    }
    
    
    var body: some View {
        
        if switchDBViewModel.isFB {
            if filteringTravelScheduleArray.count == 0{
                BlankTravelView(text: "スケジュールがありません。", imageName: "Traveler")
            }else{
                List(filteringTravelScheduleArray){ schedule in
                    RowScheduleView(travel: travel,schedule: schedule)
                        .listRowBackground(Color.clear)
                        .listRowSeparator(.hidden)
                        .listRowInsets(.init(top: 3, leading: 20, bottom: 0, trailing: 20))
                }.listStyle(GroupedListStyle())
                    .scrollContentBackground(.hidden)
                    .background(Color.list)
            }
        }else{
            if filteringTravelSchedule!.count == 0{
                BlankTravelView(text: "スケジュールがありません。", imageName: "Traveler")
            }else{
                List(filteringTravelSchedule!){ schedule in
                    RowScheduleView(travel: travel,schedule: schedule)
                        .listRowBackground(Color.clear)
                        .listRowSeparator(.hidden)
                        .listRowInsets(.init(top: 3, leading: 20, bottom: 0, trailing: 20))
                }.listStyle(GroupedListStyle())
                    .scrollContentBackground(.hidden)
                    .background(Color.list)
            }
        }
           
    }
}
