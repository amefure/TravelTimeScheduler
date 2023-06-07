//
//  FBDatabaseErrorModel.swift
//  TravelTimeScheduler
//
//  Created by t&a on 2023/05/17.
//

import UIKit

enum FBDatabaseErrorModel:Error{
    case convertFailed   // 変換失敗
    case getFailed       // 取得失敗
    case unknown         // 不明
}
