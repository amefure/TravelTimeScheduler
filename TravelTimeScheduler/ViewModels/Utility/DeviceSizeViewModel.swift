//
//  DeviceSizeModel.swift
//  FuluLog
//
//  Created by t&a on 2023/03/16.
//

import UIKit

class DeviceSizeViewModel {
    
    public let deviceWidth = UIScreen.main.bounds.width
    public let deviceHeight = UIScreen.main.bounds.height
    // 端末設定のカレンダー
    public let calendar = Calendar.current
    
    public var isSESize:Bool {
        if deviceWidth < 400{
            return true
        }else{
            return false
        }
    }
    
    public var isiPadSize:Bool {
        if UIDevice.current.userInterfaceIdiom == .pad {
            return true
        }else{
            return false
        }
    }
    
    public var flexWidth:Double {
        if self.isiPadSize {
            return self.deviceWidth/1.5
        }else{
            return self.deviceWidth
        }
    }
}

