//
//  UIColorExtension.swift
//  Unity
//
//  Created by Faizan Ali  on 2021/2/17.
//

import Foundation

import UIKit

extension UIColor {
    static let placeholder = UIColor(named: "placeholder")!
    static let bgColor = UIColor(named: "bgColor")!
    static let primaryColor = UIColor(named: "primaryColor")!
    static let secondaryColor = UIColor(named: "secondaryColor")!
    static let tint1 = UIColor(named: "tint1")!
    static let tint2 = UIColor(named: "tint2")!
    static let tint3 = UIColor(named: "tint3")!
    static let groupBackground = UIColor(named: "groupBackground")!
    
}

extension UIColor {
    public convenience init(rgb: (r: CGFloat, g: CGFloat, b: CGFloat)) {
        self.init(red: rgb.r/255, green: rgb.g/255, blue: rgb.b/255, alpha: 1.0)
    }
}

extension UIColor{
    
    /// Converting hex string to UIColor
    ///
    /// - Parameter hexString: input hex string
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3:
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6:
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8:
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}
