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

    @UserDefault(key: "profileImageURL", defaultValue: "")
    static var profileImageURL: String

    @UserDefault(key: "encyclopediaPercent", defaultValue: 0.0)
    static var encyclopediaPercent: Double

    @UserDefault(key: "isActive", defaultValue: false)
    static var isActive: Bool

    @UserDefault(key: "verified", defaultValue: false)
    static var verified: Bool
    
    @UserDefault(key: "isLoggedIn", defaultValue: false)
    static var isLoggedIn: Bool
}
