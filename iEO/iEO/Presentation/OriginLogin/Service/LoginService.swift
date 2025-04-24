//
//  LoginService.swift
//  iEO
//
//  Created by Demian Yoo on 4/24/25.
//

// MARK: - Service

import FirebaseFunctions
import FirebaseFirestore

final class LoginService {
    private let functions = Functions.functions()
    private let db = Firestore.firestore()
    
    func sendAuthCode(to email: String, completion: @escaping (Result<Void, Error>) -> Void) {
        let code = String(format: "%06d", Int.random(in: 0...999999))
        let ref = db.collection("emailAuthCodes").document(email)
        
        ref.setData([
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
        let ref = db.collection("emailAuthCodes").document(email)
        
        ref.getDocument { snapshot, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = snapshot?.data(),
                  let model = EmailLoginAuthCode(data: data) else {
                completion(.failure(NSError(domain: "", code: 404, userInfo: [NSLocalizedDescriptionKey: "인증코드 없음"])))
                return
            }
            
            if model.isExpired {
                completion(.failure(NSError(domain: "", code: 401, userInfo: [NSLocalizedDescriptionKey: "인증코드 만료"])))
                return
            }
            
            completion(.success(model.code == inputCode))
        }
    }
}
