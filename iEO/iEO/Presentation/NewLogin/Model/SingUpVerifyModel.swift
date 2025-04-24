//
//  SingUpVerifyModel.swift
//  iEO
//
//  Created by Demian Yoo on 4/24/25.
//

import Foundation
import FirebaseFirestore

struct NicknameUser: Codable {
    let nickname: String
    let verified: Bool

    init?(data: [String: Any]) {
        guard let nickname = data["nickname"] as? String,
              let verified = data["verified"] as? Bool else {
            return nil
        }
        self.nickname = nickname
        self.verified = verified
    }
}

extension NicknameUser {
    static func from(snapshot: QueryDocumentSnapshot) -> NicknameUser? {
        return NicknameUser(data: snapshot.data())
    }
}
