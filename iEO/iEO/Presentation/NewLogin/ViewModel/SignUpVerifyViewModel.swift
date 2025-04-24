//
//  SignUpVerifyViewModel.swift
//  iEO
//
//  Created by Demian Yoo on 4/22/25.
//

import Foundation
import Firebase

class SignUpVerifyViewModel {
    
    private let service = VerifyService()
    
    var onSuccess: (() -> Void)?
    var onFailure: ((String) -> Void)?
    
    func submitNickname(_ nickname: String) {
        let formatted = nickname.prefix(1).uppercased() + nickname.dropFirst().lowercased()
        service.checkNicknameAndRegister(byNickname: formatted) { [weak self] result in
            switch result {
            case .success:
                self?.onSuccess?()
            case .failure(let error): // ✅ 이 부분은 switch 안에 있어야 함
                self?.onFailure?(error.localizedDescription)
            }
        }
    }
}
