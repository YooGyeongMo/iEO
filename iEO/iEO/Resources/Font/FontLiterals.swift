//
//  FontLiterals.swift
//  iEO
//
//  Created by Demian Yoo on 4/17/25.
//

import UIKit

// MARK: - Pretendard Font Name Enum

enum Pretendard: String {
    case extraLight = "Pretendard-ExtraLight"
    case thin = "Pretendard-Thin"
    case light = "Pretendard-Light"
    case regular = "Pretendard-Regular"
    case medium = "Pretendard-Medium"
    case semiBold = "Pretendard-SemiBold"
    case bold = "Pretendard-Bold"
    case extraBold = "Pretendard-ExtraBold"
    case black = "Pretendard-Black"
}


// MARK: - UI폰트 익스텐션

extension UIFont {
    static func font(_ style: Pretendard, ofSize size: CGFloat) -> UIFont {
        return UIFont(name: style.rawValue, size: size)
        ?? .systemFont(ofSize: size)
    }

    // MARK: - 사용법

    static var h1: UIFont { font(.semiBold, ofSize: 20) }
    static var h2: UIFont { font(.extraBold, ofSize: 30) }
    static var body: UIFont { font(.regular, ofSize: 14) }
    static var caption: UIFont { font(.light, ofSize: 12) }
    static var intro: UIFont {font(.medium, ofSize: 25)}
    static var launchLabel: UIFont { font( .medium, ofSize: 20)}
}
