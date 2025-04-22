//
//  UserModel.swift
//  iEO
//
//  Created by Demian Yoo on 4/22/25.
//

import UIKit
import Foundation

struct UserModel {
    let uuid: String
    let email: String
    let nickname: String
    
    let realName: String?
    let mbti: String?
    let field: String?
    let message: String? // 나의 한마디
    let jinjinga1: String?
    let jinjinga2: String?
    let jinjinga3: String?
    let hobby: String?
    let nicknameOrigin: String?
    let profileImageURL: String?
    
    let encyclopediaPercent: Double
    let isActive: Bool
    let verified: Bool
    let createdAt: Date
    
}
