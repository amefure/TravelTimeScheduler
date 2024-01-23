//
//  Travel.swift
//  TravelTimeScheduler
//
//  Created by t&a on 2023/04/07.
//

import UIKit
import RealmSwift
import SwiftUI


class Travel :Object,ObjectKeyIdentifiable {
    
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var name: String = ""           // 旅行名
    @Persisted var members: RealmSwift.List = RealmSwift.List<String>()   //メンバー
    @Persisted var startDate: Date             // 旅行開始日
    @Persisted var endDate :Date               // 旅行終了日
    @Persisted var schedules: RealmSwift.List = RealmSwift.List<Schedule>()    // タイムスケジュール
    @Persisted var share: Bool = false
    
    var readableUserlId: [String] = []
    /// 旅行期間の日付をすべて含んだ配列
    public var allTravelPeriod: [Date] {
        let displayDateViewModel = DateFormatManager()
        let start = displayDateViewModel.startOfDay(startDate) // 日付の時刻をリセット
        let end = displayDateViewModel.startOfDay(endDate)     // 日付の時刻をリセット
        let dateCount:Int = Int(start.distance(to: end) / (60 * 60 * 24))
        var dates:[Date] = []
        for i in 0...dateCount  {
            let calendar = Calendar.current
            let modifiedDate = calendar.date(byAdding: .day, value: i, to: start)
            dates.append(modifiedDate!)
        }
        return dates
    }
    
}

class Schedule:Object ,ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var id: ObjectId             // ID
    @Persisted var dateTime: Date = Date()                    // 開始時間
    @Persisted var endDateTime: Date? = nil                   // 終了時間
    @Persisted var content: String = ""                       // 内容
    @Persisted var memo: String = ""                          // memo
    @Persisted var type: ScheduleType = .other                // タイプ
    @Persisted var tranceportation: Tranceportation? = .none  // 移動手段
}

enum ScheduleType: String, PersistableEnum {
    
    case airport = "空港"
    case station = "駅"
    case hotel = "宿泊先"
    case shop = "ショップ"
    case nature = "自然"
    case sightseein = "観光地"
    case restaurant = "飲食店"
    case cafe = "カフェ"
    case home = "家"
    case other = "その他"
    
    /// ScheduleTypeのアイコンイメージ(image型)
    static func getScheduleTypeImage(_ type:ScheduleType) -> Image{
        switch type {
        case .airport:
            return Image(systemName: "airplane.departure")
        case.station:
            return Image(systemName: "tram.fill.tunnel")
        case .hotel:
            return Image(systemName: "bed.double")
        case .shop :
            return Image(systemName: "cart.fill")
        case .nature :
            return Image(systemName: "leaf")
        case.sightseein:
            return Image(systemName: "flag")
        case.restaurant:
            return Image(systemName: "fork.knife")
        case .cafe :
            return Image(systemName: "cup.and.saucer.fill")
        case .home:
            return Image(systemName: "house")
        case.other:
            return Image(systemName: "map")
        }
    }
    
    /// 文字列で受け取ったScheduleType FBRealtimedatabase
    static func getScheduleType(_ type:String) -> ScheduleType {
        switch type {
        case ScheduleType.airport.rawValue:
            return .airport
        case ScheduleType.station.rawValue:
            return .station
        case ScheduleType.hotel.rawValue:
            return .hotel
        case ScheduleType.shop.rawValue :
            return .shop
        case ScheduleType.nature.rawValue :
            return .nature
        case ScheduleType.sightseein.rawValue:
            return .sightseein
        case ScheduleType.restaurant.rawValue:
            return .restaurant
        case ScheduleType.cafe.rawValue :
            return .cafe
        case ScheduleType.home.rawValue:
            return .home
        case ScheduleType.other.rawValue:
            return .other
        default:
            return .other
        }
    }
}

enum Tranceportation: String,PersistableEnum {
    
    case airplane = "飛行機"
    case ship = "船"
    case bulletTrain = "新幹線"
    case train = "電車"
    case car = "車"
    case bus = "バス"
    case bicycle = "自転車"
    case walk = "歩き"
    case other = "その他"
    case unowned = "未設定"
    
    /// ScheduleTypeのアイコンイメージ(image型)
    static func getTranceportationTypeImage(_ type:Tranceportation) -> Image{
        switch type {
        case .airplane:
            return Image(systemName: "airplane")
        case .ship:
            return Image(systemName: "ferry")
        case .bulletTrain:
            return Image(systemName: "train.side.front.car")
        case .train:
            return Image(systemName: "tram.fill")
        case .car:
            return Image(systemName: "car")
        case .bus:
            return Image(systemName: "bus")
        case .bicycle:
            return Image(systemName: "bicycle")
        case .walk:
            return Image(systemName: "figure.walk")
        case .other:
            return Image(systemName: "arrow.down")
        case .unowned:
            return Image(systemName: "minus")
        }
    }
    
    /// 文字列で受け取ったScheduleType FBRealtimedatabase
    static func getScheduleType(_ type:String) -> Tranceportation {
        switch type {
        case Tranceportation.airplane.rawValue:
            return .airplane
        case Tranceportation.ship.rawValue:
            return .ship
        case Tranceportation.bulletTrain.rawValue:
            return .bulletTrain
        case Tranceportation.train.rawValue:
            return .train
        case Tranceportation.car.rawValue:
            return .car
        case Tranceportation.bus.rawValue:
            return .bus
        case Tranceportation.bicycle.rawValue:
            return .bicycle
        case Tranceportation.walk.rawValue:
            return .walk
        case Tranceportation.unowned.rawValue:
            return .unowned
        case Tranceportation.other.rawValue:
            return .other
        default:
            return .other
        }
    }
}
