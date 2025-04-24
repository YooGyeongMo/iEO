//
//  SignUpAuthViewModel.swift
//  iEO
//
//  Created by Demian Yoo on 4/22/25.
//
import FirebaseFirestore
import FirebaseFunctions


// MARK: - ViewModel

final class SignUpAuthViewModel {
    var onSendSuccess: (() -> Void)?
    var onError: ((String) -> Void)?
    var onVerificationSuccess: (() -> Void)?
    var onVerificationFail: ((String) -> Void)?

    private let service = SignUpAuthService()

    func sendAuthCode(to email: String) {
        service.requestAuthCode(for: email) { [weak self] result in
            switch result {
            case .success:
                self?.onSendSuccess?()
            case .failure(let error):
                self?.onError?(error.localizedDescription)
            }
        }
    }

    func verifyAuthCode(email: String, inputCode: String) {
        service.verifyAuthCode(email: email, inputCode: inputCode) { [weak self] result in
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
