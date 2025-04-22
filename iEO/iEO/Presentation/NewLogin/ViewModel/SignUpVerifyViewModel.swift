//
//  SignUpVerifyViewModel.swift
//  iEO
//
//  Created by Demian Yoo on 4/22/25.
//

import Foundation

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
            case .failure(let error):
                self?.onFailure?(error.localizedDescription)
            }
        }
    }
}
