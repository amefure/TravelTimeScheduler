//
//  ExColor.swift
//  TravelTimeScheduler
//
//  Created by t&a on 2023/04/13.
//

import UIKit
import SwiftUI

extension Color {
    init(hexString: String, alpha: CGFloat = 1.0) {
        // 不要なスペースや改行があれば除去
        let hexString: String = hexString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        // スキャナーオブジェクトの生成
        let scanner = Scanner(string: hexString)

        // 先頭(0番目)が#であれば無視させる
        if (hexString.hasPrefix("#")) {
            scanner.charactersToBeSkipped = CharacterSet(charactersIn: "#")
        }

        var color:Int64 = 0
        // 文字列内から16進数を探索し、Int64型で color変数に格納
        scanner.scanHexInt64(&color)

        let mask:Int = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask

        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0

        self.init(red:red, green:green, blue:blue,opacity: alpha)
    }

}

extension Color { 
    static let foundation: Color = Color(hexString: "#e7e7e7")
    static let opacityGray: Color = Color(hexString: "#555555", alpha: 0.2)
    static let thema: Color = Color(hexString: "#34527B")
    static let negative: Color = Color(hexString: "#C84311")
//    static let accent:Color = Color(hexString: "#ff6584")
    static let list: Color = Color(hexString: "#f2f2f7")
    static let schedule: Color = Color(hexString: "#73BBD1")
    static let accentSchedule: Color = Color(hexString: "#F4C01E")
}
