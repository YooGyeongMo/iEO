//
//  SignUpAuthViewModel.swift
//  iEO
//
//  Created by Demian Yoo on 4/22/25.
//

class SignUpAuthViewModel {
    let authService = AuthService()
    
    var onSendSuccess: (() -> Void)?
    var onError: ((String) -> Void)?
    
    var onVerificationSuccess: (() -> Void)?
    var onVerificationFail: ((String) -> Void)?
    
    // sendAuthCode 확인 로직
    func sendAuthCode(to email: String) {
        authService.requestAuthCode(for: email) { [weak self] result in
            switch result {
            case .success():
                self?.onSendSuccess?()
            case .failure(let error):
                self?.onError?(error.localizedDescription)
            }
        }
    }
    // verifyAuthCode 확인 로직
    func verifyAuthCode(email: String, inputCode: String) {
        authService.verifyAuthCode(email: email, inputCode: inputCode) { [weak self] result in
            switch result {
            case .success(true):
                self?.onVerificationSuccess?()
            case .success(false):
                self?.onVerificationFail?("인증번호가 일치하지 않습니다.")
            case .failure(let error):
                self?.onVerificationFail?(error.localizedDescription)
            }
        }
    }
}
