//
//  SignUpAuthService.swift
//  iEO
//
//  Created by Demian Yoo on 4/24/25.
//

import Foundation
import FirebaseFirestore
import FirebaseFunctions

// MARK: - Service

final class SignUpAuthService {
    private let db = Firestore.firestore()
    private let functions = Functions.functions()

    func requestAuthCode(for email: String, completion: @escaping (Result<Void, Error>) -> Void) {
        let code = String(format: "%06d", Int.random(in: 0...999999))
        let docRef = db.collection("emailAuthCodes").document(email)

        docRef.setData([
            "code": code,
            "createdAt": FieldValue.serverTimestamp()
        ]) { error in
            if let error = error {
                completion(.failure(error))
                return
            }

            self.functions.httpsCallable("sendEmailVerificationCode").call(["email": email, "code": code]) { result, error in
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.success(()))
                }
            }
        }
    }

    func verifyAuthCode(email: String, inputCode: String, completion: @escaping (Result<Bool, Error>) -> Void) {
        let docRef = db.collection("emailAuthCodes").document(email)
        docRef.getDocument { docSnapshot, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = docSnapshot?.data(),
                  let model = EmailAuthCode(data: data) else {
                completion(.failure(NSError(domain: "EmailAuth", code: -1, userInfo: [NSLocalizedDescriptionKey: "인증 정보가 유효하지 않습니다."])))
                return
            }

            if model.isExpired {
                completion(.failure(NSError(domain: "EmailAuth", code: -2, userInfo: [NSLocalizedDescriptionKey: "인증 코드가 만료되었습니다."])))
                return
            }

            completion(.success(model.code == inputCode))
        }
    }
}
