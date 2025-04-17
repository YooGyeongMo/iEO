//
//  ColorLiterals.swift
//  iEO
//
//  Created by Demian Yoo on 4/17/25.
//

import UIKit

import UIKit

// MARK: - App Color Enum

enum AppColor: String {
    case textPrimary = "TextPrimary"   // #0F1A12
    case background = "Background"     // #6E6660
    case accent = "Accent"             // #EDE7E3
    // 필요한 만큼 계속 추가 가능
}

// MARK: - UIColor Extension for AppColor

extension UIColor {
    static func color(_ name: AppColor) -> UIColor {
        return UIColor(named: name.rawValue) ?? .clear
    }
    
    // MARK: - Semantic Color Access
    static var appTextPrimary: UIColor { color(.textPrimary) }
    static var appBackground: UIColor { color(.background) }
    static var appAccent: UIColor { color(.accent) }
    
}
