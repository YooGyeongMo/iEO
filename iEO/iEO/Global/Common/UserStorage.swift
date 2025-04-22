//
//  UserStorage.swift
//  iEO
//
//  Created by Demian Yoo on 4/22/25.
//


import Foundation

struct UserStorage {
    @UserDefault(key: "uid", defaultValue: "")
    static var uid: String
    
    @UserDefault(key: "email", defaultValue: "")
    static var email: String

    @UserDefault(key: "nickname", defaultValue: "")
    static var nickname: String

    @UserDefault(key: "realName", defaultValue: "")
    static var realName: String

    @UserDefault(key: "mbti", defaultValue: "")
    static var mbti: String

    @UserDefault(key: "field", defaultValue: "")
    static var field: String

    @UserDefault(key: "message", defaultValue: "")
    static var message: String

    @UserDefault(key: "jinjinga1", defaultValue: "")
    static var jinjinga1: String

    @UserDefault(key: "jinjinga2", defaultValue: "")
    static var jinjinga2: String

    @UserDefault(key: "jinjinga3", defaultValue: "")
    static var jinjinga3: String

    @UserDefault(key: "hobby", defaultValue: "")
    static var hobby: String

    @UserDefault(key: "nicknameOrigin", defaultValue: "")
    static var nicknameOrigin: String

    @UserDefault(key: "profileImageURL", defaultValue: "")
    static var profileImageURL: String

    @UserDefault(key: "encyclopediaPercent", defaultValue: 0.0)
    static var encyclopediaPercent: Double

    @UserDefault(key: "isActive", defaultValue: true)
    static var isActive: Bool

    @UserDefault(key: "verified", defaultValue: false)
    static var verified: Bool
}
