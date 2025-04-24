//
//  LoginViewController.swift
//  iEO
//
//  Created by Demian Yoo on 4/21/25.
//


import UIKit
import Toast


class LoginViewController: UIViewController {
    
    weak var coordinator: AppCoordinator?
    
    private var verificationSent = false
    private let viewModel = LoginViewModel()
    
    private let loginLogoImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "loginLogo"))
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let loginLabel: UILabel = {
        let label = UILabel()
        label.text = "아카데미 이메일로 로그인해 주세요."
        label.font = .mediumLabel
        label.textColor = .appBackground
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let loginEmailLabel: UILabel = {
        let label = UILabel()
        label.text = "이메일"
        label.font = .authLabel
        label.textColor = .appTextPrimary
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let loginEmailTextField: PaddedTextField = {
        let textField = PaddedTextField()
        textField.layer.cornerRadius = 15
        textField.font = .mediumLabel
        textField.textColor = .accent
        textField.backgroundColor = .appBackground
        textField.attributedPlaceholder = NSAttributedString(
            string: "example@pos.idserve.net",
            attributes: [
                .foregroundColor: UIColor.accent.withAlphaComponent(0.6),
                .font: UIFont.mediumLabel
            ]
        )
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let loginNumberLabel: UILabel = {
        let label = UILabel()
        label.text = "인증번호"
        label.font = .authLabel
        label.textColor = .appTextPrimary
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let loginNumberTextField: PaddedTextField = {
        let textField = PaddedTextField()
        textField.layer.cornerRadius = 15
        textField.font = .mediumLabel
        textField.textColor = .accent
        textField.backgroundColor = .appBackground
        textField.attributedPlaceholder = NSAttributedString(
            string: "인증번호",
            attributes: [
                .foregroundColor: UIColor.accent.withAlphaComponent(0.6),
                .font: UIFont.mediumLabel
            ]
        )
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("인증 번호 보내기", for: .normal)
        button.setTitleColor(.accent, for: .normal)
        button.setTitleColor(.white, for: .highlighted)
        button.isEnabled = false
        button.alpha = 0.3
        button.backgroundColor = .textPrimary
        button.titleLabel?.font = .mediumLabel
        button.layer.cornerRadius = 15
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let reSendLoginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("다시 보내기", for: .normal)
        button.setTitleColor(.textPrimary, for: .normal)
        button.titleLabel?.font = .mediumLabel
        button.backgroundColor = .clear
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setUpViews()
        configureInitialHiddenState()
        bindViewModel()
        configureActions()
        title = "기존 러너 로그인"
    }
    
    private func setUpViews() {
        view.backgroundColor = .accent
        view.addSubview(loginLogoImageView)
        view.addSubview(loginLabel)
        view.addSubview(loginEmailLabel)
        view.addSubview(loginEmailTextField)
        view.addSubview(loginNumberLabel)
        view.addSubview(loginNumberTextField)
        view.addSubview(loginButton)
        view.addSubview(reSendLoginButton)
        
        
        NSLayoutConstraint.activate([
            
            loginLogoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant:10),
            loginLogoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginLogoImageView.heightAnchor.constraint(equalToConstant: 110),
            loginLogoImageView.widthAnchor.constraint(equalToConstant: 75),
            
            loginLabel.topAnchor.constraint(equalTo: loginLogoImageView.bottomAnchor, constant: 20),
            loginLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            loginEmailLabel.topAnchor.constraint(equalTo: loginLabel.bottomAnchor, constant:20),
            loginEmailLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant:16),
            
            loginEmailTextField.topAnchor.constraint(equalTo: loginEmailLabel.bottomAnchor,constant:20),
            loginEmailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant:16),
            loginEmailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16 ),
            loginEmailTextField.heightAnchor.constraint(equalToConstant: 50),
            
            loginNumberLabel.topAnchor.constraint(equalTo: loginEmailTextField.bottomAnchor, constant:20),
            loginNumberLabel.leadingAnchor.constraint(equalTo:view.leadingAnchor, constant:16),
            
            loginNumberTextField.topAnchor.constraint(equalTo: loginNumberLabel.bottomAnchor,constant:20),
            loginNumberTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant:16),
            loginNumberTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant:-16),
            loginNumberTextField.heightAnchor.constraint(equalToConstant: 50),
            
            loginButton.topAnchor.constraint(equalTo: loginNumberTextField.bottomAnchor, constant: 40),
            loginButton.leadingAnchor.constraint(equalTo:view.leadingAnchor, constant: 90),
            loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -90),
            loginButton.heightAnchor.constraint(equalToConstant: 50),
            
            reSendLoginButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 20),
            reSendLoginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            
        ])
    }
    
    private func configureInitialHiddenState() {
        [loginNumberLabel,loginNumberTextField,reSendLoginButton].forEach {
            $0.isHidden = true
        }
    }
    
    private func bindViewModel() {
        viewModel.onSendSuccess = { [weak self] in
            DispatchQueue.main.async {
                self?.loginButton.setTitle("인증번호 확인하기", for: .normal)
                self?.reSendLoginButton.isHidden = false
                self?.loginNumberLabel.isHidden = false
                self?.loginNumberTextField.isHidden = false
                self?.verificationSent = true
                self?.showToast(LoginMessage.codeSent)
            }
        }
        
        viewModel.onVerifySuccess = { [weak self] in
            DispatchQueue.main.async {
                self?.coordinator?.goToLoading()
            }
        }
        
        viewModel.onFailure = { [weak self] message in
            DispatchQueue.main.async {
                self?.showToast(message)
            }
        }
    }
    
    private func configureActions() {
        loginEmailTextField.addTarget(self, action: #selector(emailTextFieldChanged), for: .editingChanged)
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        reSendLoginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
    }
    
    @objc private func loginButtonTapped() {
        guard let email = loginEmailTextField.text, !email.isEmpty else {
            showToast(LoginMessage.emptyEmail)
            return
        }
        
        if verificationSent {
            guard let code = loginNumberTextField.text, !code.isEmpty else {
                showToast(LoginMessage.invalidCode)
                return
            }
            viewModel.verifyCode(email: email, code: code)
        } else {
            viewModel.sendCode(to: email)
        }
    }
    
    @objc private func emailTextFieldChanged() {
        let email = loginEmailTextField.text ?? ""
        let isValid = viewModel.isValidAcademyEmail(email)
        loginButton.isEnabled = isValid
        loginButton.alpha = isValid ? 1.0 : 0.3
    }
    
    private func showToast(_ message: String) {
        view.makeToast(message, duration: 2.0, position: .center)
    }
}

// MARK: - 메시지 정의

enum LoginMessage {
    static let emptyEmail = NSLocalizedString("이메일을 입력해주세요", comment: "Empty email warning")
    static let invalidCode = NSLocalizedString("인증번호 입력해주세요.", comment: "Empty code warning")
    static let codeSent = NSLocalizedString("인증번호 보냈어요 🎉", comment: "Code sent success")
}
