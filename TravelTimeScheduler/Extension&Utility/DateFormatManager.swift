//
//  DateFormatManager.swift
//  TravelTimeScheduler
//
//  Created by t&a on 2023/04/16.
//

import UIKit

class DateFormatManager {
    // MARK: - 日付表示用モデル
    // DateFormatterをプロパティに持つ
    // 日付の表示形式を変更する
    
    private let df: DateFormatter = DateFormatter()
    private let calendar: Calendar = Calendar.current
    
    init(){
        df.calendar = Calendar(identifier: .gregorian)
        df.locale = Locale(identifier: "ja_JP")
        df.timeZone = TimeZone(identifier: "Asia/Tokyo")
        df.dateStyle = .short
        df.timeStyle = .none
    }
    /// yyyy/MM/dd形式：年月日のみ
    public func getDateDisplayFormatString(_ date:Date) -> String{
        df.dateFormat = "yyyy/MM/dd"
        return df.string(from: date)
    }
    
    // FBRealtimeDatebase
    /// yyyy/MM/dd H：mm形式：年月日時間
    public func getAllDateDisplayFormatString(_ date:Date) -> String{
        df.dateFormat = "yyyy/MM/dd H：mm"
        return df.string(from: date)
    }
    
    /// yyyy年M月dd日形式：年月日のみ
    public func getJapanDateDisplayFormatString(_ date:Date) -> String{
        df.dateFormat = "yyyy年M月dd日"
        return df.string(from: date)
    }
    
    /// M/dd形式：日付のみ
    public func getShortDateDisplayFormatString(_ date:Date) -> String{
        df.dateFormat = "M/dd"
        return df.string(from: date)
    }
    
    /// H：mm形式：時間のみ
    public func getTimeDisplayFormatString(_ date:Date) -> String{
        df.dateFormat = "H：mm"
        return df.string(from: date)
    }
    
    /// DateのstartOfDay
    public func startOfDay(_ date:Date) -> Date{
        return calendar.startOfDay(for: date)
    }
    
    // SearchBox
    /// yyyy/MM/dd形式の文字列をDate型で返す
    public func getYearStringDateArray(_ year:String) -> [Date]{
        df.dateFormat = "yyyy/MM/dd"
        let start = df.date(from: "\(year)/1/1")!
        let end = df.date(from:  "\(year)/12/31")!
        return [start,end]
    }
    
    // FBRealtimeDatebase
    /// yyyy/MM/dd H：mm形式の文字列をDate型で返す
    public func getAllDateStringDate(_ date:String) -> Date{
        df.dateFormat = "yyyy/MM/dd H：mm"
        return df.date(from: date)!
    }
}

