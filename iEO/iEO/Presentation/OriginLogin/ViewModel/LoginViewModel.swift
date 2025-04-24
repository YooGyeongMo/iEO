//
//  LoginViewModel.swift
//  iEO
//
//  Created by Demian Yoo on 4/24/25.
//
import Foundation

final class LoginViewModel {
    private let service = LoginService()

    var onSendSuccess: (() -> Void)?
    var onVerifySuccess: (() -> Void)?
    var onFailure: ((String) -> Void)?

    func sendCode(to email: String) {
        service.sendAuthCode(to: email) { [weak self] result in
            switch result {
            case .success:
                self?.onSendSuccess?()
            case .failure(let error):
                self?.onFailure?(error.localizedDescription)
            }
        }
    }

    func verifyCode(email: String, code: String) {
        service.verifyAuthCode(email: email, inputCode: code) { [weak self] result in
            switch result {
            case .success(true):
                UserStorage.email = email
                UserStorage.isLoggedIn = true
                self?.onVerifySuccess?()
            case .success(false):
                self?.onFailure?("인증번호가 틀렸습니다.")
            case .failure(let error):
                self?.onFailure?(error.localizedDescription)
            }
        }
    }
    
    func isValidAcademyEmail(_ email: String) -> Bool {
        return email.hasSuffix("@pos.idserve.net") && email.contains("@")
    }
}
