//
//  Color+Extension.swift
//  Reusable_framework
//
//  Created by BJIT on 2021/07/14.
//

import Foundation
import UIKit

extension UIColor {
    
    convenience init(red: Int, green: Int, blue: Int, alpha: CGFloat = 1.0) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }

    convenience init(hexCode: String, alpha: CGFloat = 1.0) {
        var colorCode = hexCode
        if hexCode.prefix(1) == "#" {
            colorCode = String(hexCode[hexCode.index(after: hexCode.startIndex)..<hexCode.endIndex])
        }
        
        let v = colorCode.map { String($0) } + Array(repeating: "0", count: max(6 - colorCode.count, 0))
        let r = CGFloat(Int(v[0] + v[1], radix: 16) ?? 0) / 255.0
        let g = CGFloat(Int(v[2] + v[3], radix: 16) ?? 0) / 255.0
        let b = CGFloat(Int(v[4] + v[5], radix: 16) ?? 0) / 255.0
        self.init(red: r, green: g, blue: b, alpha: alpha)
    }
    
}
