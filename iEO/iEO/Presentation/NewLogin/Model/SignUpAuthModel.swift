//
//  SignUpAuthModel.swift
//  iEO
//
//  Created by Demian Yoo on 4/24/25.
//
import Foundation
import FirebaseFirestore

// MARK: - Model

struct EmailAuthCode {
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
