//
//  SignUpAuthViewController.swift
//  iEO
//
//  Created by Demian Yoo on 4/21/25.
//

import UIKit
import SwiftUI

class SignUpAuthViewController: UIViewController {
    
    //ViewModel 바인딩.
    weak var coordinator: AppCoordinator?
    private let viewModel = SignUpAuthViewModel()
    
    //MARK: - UI
    
    private let ifSendAuthLabel: UILabel = {
        let label = UILabel()
        label.text = "인증 시간"
        label.font = .authTimeLabel
        label.textColor = .textPrimary
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let ifSendAuthTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "5:00"
        label.font = .authTimeLabel
        label.textColor = .textPrimary
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let mailImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "mail"))
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "아카데미 이메일로 인증해주세요."
        label.font = .mediumLabel
        label.textColor = .appBackground
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let ifSendAuthInvaildLabel: UILabel = {
        let label = UILabel()
        label.text = "옳지 않은 인증번호입니다."
        label.font = .mediumLabel
        label.textColor = .textPrimary
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let emailLabel: UILabel = {
        let label = UILabel()
        label.text = "이메일"
        label.font = .authLabel
        label.textColor = .appTextPrimary
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let emailTextField: PaddedTextField = {
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
    
    private let ifSendAuthNumberLabel: UILabel = {
        let label = UILabel()
        label.text = "인증번호"
        label.font = .authLabel
        label.textColor = .appTextPrimary
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let ifSendAuthNumberTextField: PaddedTextField = {
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
    
    private let sendAuthButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("인증 번호 보내기", for: .normal)
        button.setTitleColor(.accent, for: .normal)
        button.isEnabled = false
        button.alpha = 0.3
        button.backgroundColor = .textPrimary
        button.titleLabel?.font = .mediumLabel
        button.layer.cornerRadius = 15
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let reSendAuthButton: UIButton = {
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
        view.backgroundColor = .accent
        setUpViews()
        configureInitialHiddenState()
        bindViewModel()
        configureActions()
        title = "러너 인증"
    }
    
    
    private func setUpViews() {
        view.backgroundColor = .accent
        view.addSubview(mailImageView)
        view.addSubview(descriptionLabel)
        
        view.addSubview(emailLabel)
        view.addSubview(emailTextField)
        
        view.addSubview(ifSendAuthLabel)
        view.addSubview(ifSendAuthTimeLabel)
        
        view.addSubview(ifSendAuthInvaildLabel)
        
        view.addSubview(ifSendAuthNumberLabel)
        view.addSubview(ifSendAuthNumberTextField)
        
        view.addSubview(sendAuthButton)
        view.addSubview(reSendAuthButton)
        
        
        NSLayoutConstraint.activate([
            
            ifSendAuthLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            ifSendAuthLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            ifSendAuthTimeLabel.topAnchor.constraint(equalTo: ifSendAuthLabel.bottomAnchor,constant: 10),
            ifSendAuthTimeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            mailImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mailImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mailImageView.widthAnchor.constraint(equalToConstant: 390),
            mailImageView.heightAnchor.constraint(equalToConstant: 390),
            
            descriptionLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 290),
            descriptionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            ifSendAuthInvaildLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 15),
            ifSendAuthInvaildLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            emailLabel.leadingAnchor.constraint(equalTo:view.leadingAnchor, constant:16),
            emailLabel.topAnchor.constraint(equalTo:descriptionLabel.bottomAnchor, constant:70),
            
            emailTextField.leadingAnchor.constraint(equalTo:emailLabel.leadingAnchor),
            emailTextField.topAnchor.constraint(equalTo:emailLabel.bottomAnchor, constant:15),
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            emailTextField.heightAnchor.constraint(equalToConstant: 50),
            
            ifSendAuthNumberLabel.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 15),
            ifSendAuthNumberLabel.leadingAnchor.constraint(equalTo: emailLabel.leadingAnchor),
            
            ifSendAuthNumberTextField.topAnchor.constraint(equalTo: ifSendAuthNumberLabel.bottomAnchor, constant: 15),
            ifSendAuthNumberTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            ifSendAuthNumberTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            ifSendAuthNumberTextField.heightAnchor.constraint(equalToConstant: 50),
            
            sendAuthButton.topAnchor.constraint(equalTo: ifSendAuthNumberTextField.bottomAnchor, constant: 30),
            sendAuthButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 90),
            sendAuthButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -90),
            sendAuthButton.heightAnchor.constraint(equalToConstant: 50),
            
            reSendAuthButton.topAnchor.constraint(equalTo:sendAuthButton.bottomAnchor, constant: 15),
            reSendAuthButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }

    private func configureInitialHiddenState() {
        [ifSendAuthLabel, ifSendAuthTimeLabel, ifSendAuthInvaildLabel,
         ifSendAuthNumberLabel, ifSendAuthNumberTextField, reSendAuthButton].forEach {
            $0.isHidden = true
        }
    }
    
    private func bindViewModel() {
        //1초마다 업데이트
        viewModel.onTimeChanged = { [weak self] formattedTime in
            DispatchQueue.main.async {
                self?.ifSendAuthTimeLabel.text = formattedTime
            }
        }
        
    }
    // MARK: - 이메일 텍스트 필드 바뀔 때 마다
    @objc private func emailTextFieldChanged() {
        let email = emailTextField.text ?? ""
        let isValid  = email.hasSuffix("@pos.idserve.net") && email.contains("@")
        sendAuthButton.isEnabled = isValid
        sendAuthButton.alpha = isValid ? 1.0 : 0.3
    }
    
    // MARK: - 이메일 확인 버튼
    @objc private func handleSendAuthButtonTapped() {
        //타이머 시작
        viewModel.start()
        sendAuthButton.setTitle("인증 번호 확인하기", for: .normal)
        
        [ifSendAuthLabel, ifSendAuthTimeLabel, ifSendAuthNumberLabel, ifSendAuthNumberTextField, reSendAuthButton].forEach {
            $0.isHidden = false
        }
    }
    // MARK: - 이메일 확인 새로 보내기
    @objc private func handleResendButtonTapped() {
        viewModel.reset()
    }
    
    // MARK: - 버튼 이벤트
    private func configureActions() {
        emailTextField.addTarget(self, action: #selector(emailTextFieldChanged), for: .editingChanged)
        sendAuthButton.addTarget(self, action: #selector(handleSendAuthButtonTapped), for: .touchUpInside)
        reSendAuthButton.addTarget(self, action: #selector(handleResendButtonTapped), for: .touchUpInside)
    }
    
    private func showInvaildMessage() {
        ifSendAuthInvaildLabel.isHidden = false
    }
    
}

struct PreView: PreviewProvider {
    static var previews: some View {
        // Preview를 보고자 하는 ViewController를 넣으면 됩니다.
        SignUpAuthViewController().toPreview()
    }
}
