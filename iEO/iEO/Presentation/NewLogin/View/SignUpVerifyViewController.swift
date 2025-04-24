//
//  SignUpVerifyViewController.swift
//  iEO
//
//  Created by Demian Yoo on 4/22/25.
//

import UIKit
import Toast

class SignUpVerifyViewController: UIViewController {
    
    weak var coordinator: AppCoordinator?
    private let viewModel = SignUpVerifyViewModel()
    
    //MARK: - UI
    private let mailImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "mail"))
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "이메일 인증이 정상적으로 완료되었습니다."
        label.font = .mediumLabel
        label.textColor = .appBackground
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let deatilDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = """
        사용자 맞춤형 경험 제공을 위해 러너의 기본 정보
        (이름, 닉네임, 세션, 관심 분야, 취미, MBTI, 진진가 등)를
        수집 및 활용하는 데에 동의하신다면 아래에 닉네임을 적어주세요.
        """
        label.textColor = .appBackground
        label.font = .body
        label.textAlignment = .center
        label.numberOfLines = 0  // ✅ 여러 줄 허용!
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let nicknameLabel: UILabel = {
        let label = UILabel()
        label.text = "영어 닉네임"
        label.font = .h1
        label.textColor = .appBackground
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let nicknameTextField: PaddedTextField = {
        let textField = PaddedTextField()
        textField.layer.cornerRadius = 15
        textField.font = .mediumLabel
        textField.textColor = .accent
        textField.backgroundColor = .appBackground
        textField.attributedPlaceholder = NSAttributedString(
            string: "영어로 닉네임",
            attributes: [
                .foregroundColor: UIColor.accent.withAlphaComponent(0.6),
                .font: UIFont.mediumLabel
            ]
        )
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let sendVerifyButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("동의", for: .normal)
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
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "러너인증 완료"
        view.backgroundColor = .accent
        setUpViews()
        configureActions()
        setupKeyboardObserver()
    }
    
    private func setUpViews() {
        
        view.addSubview(mailImageView)
        view.addSubview(descriptionLabel)
        view.addSubview(deatilDescriptionLabel)
        view.addSubview(nicknameLabel)
        view.addSubview(nicknameTextField)
        view.addSubview(sendVerifyButton)
        
        NSLayoutConstraint.activate([
            mailImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mailImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mailImageView.widthAnchor.constraint(equalToConstant: 390),
            mailImageView.heightAnchor.constraint(equalToConstant: 390),
            
            descriptionLabel.topAnchor.constraint(equalTo:view.safeAreaLayoutGuide.topAnchor, constant:330),
            descriptionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            deatilDescriptionLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant:30),
            deatilDescriptionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            nicknameLabel.topAnchor.constraint(equalTo: deatilDescriptionLabel.bottomAnchor, constant: 20),
            nicknameLabel.centerXAnchor.constraint(equalTo:view.centerXAnchor),
            
            nicknameTextField.topAnchor.constraint(equalTo: nicknameLabel.bottomAnchor, constant: 20),
            nicknameTextField.leadingAnchor.constraint(equalTo:view.leadingAnchor, constant:90),
            nicknameTextField.trailingAnchor.constraint(equalTo:view.trailingAnchor, constant:-90),
            nicknameTextField.heightAnchor.constraint(equalToConstant: 50),
            
            sendVerifyButton.topAnchor.constraint(equalTo: nicknameTextField.bottomAnchor, constant: 40),
            sendVerifyButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            sendVerifyButton.heightAnchor.constraint(equalToConstant: 40),
            sendVerifyButton.widthAnchor.constraint(equalToConstant: 150),
            
        ])
    }
    
    private func configureActions() {
        nicknameTextField.addTarget(self, action: #selector(handleNicknameChanged), for: .editingChanged)
        sendVerifyButton.addTarget(self, action: #selector(handleVerifyTapped), for: .touchUpInside)
        // ViewModel 콜백 바인딩
        viewModel.onSuccess = { [weak self] in
            self?.coordinator?.goToLoading()
        }
        
        viewModel.onFailure = { [weak self] message in
            DispatchQueue.main.async {
                self?.view.makeToast(message, duration: 2.0, position: .center)
            }
        }
    }
    
    @objc private func handleNicknameChanged() {
        guard let text = nicknameTextField.text, !text.isEmpty else {
            sendVerifyButton.isEnabled = false
            sendVerifyButton.alpha = 0.3
            return
        }
        let isEnglish = text.range(of: "^[A-Za-z]{1,8}$", options: .regularExpression) != nil
        sendVerifyButton.isEnabled = isEnglish
        sendVerifyButton.alpha = isEnglish ? 1.0 : 0.3
    }
    
    @objc private func handleVerifyTapped() {
        guard var nickname = nicknameTextField.text, !nickname.isEmpty else {
            self.view.makeToast("닉네임을 입력해주세요.", duration: 2.0, position: .center)
            return
        }
        nickname = nickname.prefix(1).uppercased() + nickname.dropFirst().lowercased()
        viewModel.submitNickname(nickname)
    }
    
    private func setupKeyboardObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc private func keyboardWillShow(_ notification: Notification) {
        guard let userInfo = notification.userInfo,
              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
        let bottomInset = keyboardFrame.height
        view.frame.origin.y = -bottomInset / 2
    }
    
    @objc private func keyboardWillHide(_ notification: Notification) {
        view.frame.origin.y = 0
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    
}
