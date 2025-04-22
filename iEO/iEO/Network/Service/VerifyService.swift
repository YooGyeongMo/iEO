//
//  VerifyService.swift
//  iEO
//
//  Created by Demian Yoo on 4/23/25.
//

import FirebaseFirestore

final class VerifyService {
    private let db = Firestore.firestore()
    
    func checkNicknameAndRegister(byNickname nickname: String, completion: @escaping (Result<Void, Error>) -> Void) {
        let userCollection = db.collection("users")
        
        userCollection.whereField("nickname", isEqualTo: nickname).getDocuments { snapshot, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let document = snapshot?.documents.first else {
                completion(.failure(NSError(domain: "", code: 404, userInfo: [NSLocalizedDescriptionKey: "존재하지 않는 닉네임입니다."])))
                return
            }
            
            let data = document.data()
            let isAlreadyVerified = data["verified"] as? Bool ?? false
            if isAlreadyVerified {
                completion(.failure(NSError(domain: "", code: 409, userInfo: [NSLocalizedDescriptionKey: "이미 인증된 닉네임입니다."])))
                return
            }
            
            let updates: [String: Any] = [
                "email": UserStorage.email,
                "verified": true,
                "isActive": true,
                "createdAt": FieldValue.serverTimestamp(),
                "nickname": nickname,
                "encyclopediaPercent": 0.0,
                "profileImageURL": ""
            ]
            
            userCollection.document(document.documentID).updateData(updates) { error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                // ✅ 로컬 저장
                UserStorage.uid = document.documentID
                UserStorage.nickname = nickname
                UserStorage.verified = true
                UserStorage.isActive = true
                UserStorage.encyclopediaPercent = 0.0
                UserStorage.profileImageURL = ""
                
                completion(.success(()))
            }
        }
    }
}
