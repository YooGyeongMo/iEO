//
//  LoginModel.swift
//  iEO
//
//  Created by Demian Yoo on 4/24/25.
//

// MARK: - Model

import Foundation
import FirebaseFirestore

struct EmailLoginAuthCode {
    let code: String
    let createdAt: Date

    init?(data: [String: Any]) {
        guard let code = data["code"] as? String,
              let timestamp = data["createdAt"] as? Timestamp else {
            return nil
        }
        self.code = code
        self.createdAt = timestamp.dateValue()
    }

    var isExpired: Bool {
        return Date().timeIntervalSince(createdAt) > 300
    }
}
