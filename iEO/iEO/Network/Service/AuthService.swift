//
//  AuthService.swift
//  iEO
//
//  Created by Demian Yoo on 4/22/25.
//

import FirebaseFunctions
import FirebaseFirestore


final class AuthService {
    private let functions = Functions.functions()
    private let db = Firestore.firestore()

    // 인증코드 보내기
    func requestAuthCode(for email: String, completion: @escaping (Result<Void, Error>) -> Void) {
        let code = String(format: "%06d", Int.random(in: 0...999999))

        // Firestore에 저장
        let docRef = db.collection("emailAuthCodes").document(email)
        docRef.setData([
            "code": code,
            "createdAt": FieldValue.serverTimestamp()
        ]) { error in
            if let error = error {
                completion(.failure(error))
                return
            }

            // Firebase Function 호출
            self.functions.httpsCallable("sendEmailVerificationCode").call(["email": email, "code": code]) { result, error in
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.success(()))
                }
            }
        }
    }
    
    // 인증코드 검증
    func verifyAuthCode(email: String, inputCode: String, completion: @escaping (Result<Bool, Error>) -> Void) {
        let docRef = db.collection("emailAuthCodes").document(email)
        docRef.getDocument { docSnapshot, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = docSnapshot?.data(),
                  let savedCode = data["code"] as? String,
                  let timestamp = data["createdAt"] as? Timestamp else {
                completion(.failure(NSError(domain: "FireStore/NoAuthCode", code: -1, userInfo: [
                    NSLocalizedDescriptionKey: "저장된 인증 코드가 없습니다."
                ])))
                return
            }
            
            let createdDate = timestamp.dateValue()
            let now = Date()
            // 지금 시간과 createdDate사이 경과된 시간.
            let elapsed = now.timeIntervalSince(createdDate)
            
            if elapsed > 300 {
                completion(.failure(NSError(domain: "FireStore/AuthCodeExpired", code: -2, userInfo: [
                    NSLocalizedDescriptionKey: "인증 코드가 만료되었습니다. 다시 시도하세요."
                ])))
                return
                
            }

            completion(.success(savedCode == inputCode))
        }
    }
}
