//
//  IntroViewController.swift
//  iEO
//
//  Created by Demian Yoo on 4/18/25.
//

import UIKit

// MARK: - 인트로 뷰컨트롤러 델리게이트 프로토콜 바인딩
class IntroViewController: UIViewController {
    
    weak var coordinator: AppCoordinator?
    private var isModalExpanded = false
    private var modalConstraints: [NSLayoutConstraint] = []
    private var originalConstraints: [NSLayoutConstraint] = []
    
    private let introImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "introConnection"))
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.alpha = 0
        return imageView
    }()
    
    private let subLabel: UILabel = {
        let label = UILabel()
        label.text = "\"마음의 수면을 깨우는 순간\""
        label.font = .launchLabel
        label.textColor = .accent
        label.textAlignment = .center
        label.alpha = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let subLabel2: UILabel = {
        let label = UILabel()
        label.text = "\"조용한 파동이 번지고\""
        label.font = .launchLabel
        label.textColor = .accent
        label.textAlignment = .center
        label.alpha = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let subLabel3: UILabel = {
        let label = UILabel()
        label.text = "\"우리의 울림이 닿습니다.\""
        label.font = .intro
        label.textColor = .textPrimary
        label.textAlignment = .center
        label.alpha = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let startButton: RadiusSquare = {
        let button = RadiusSquare(title: "Emotional Connection", textColor: .textPrimary)
        button.alpha = 0
        button.configure(for: .compact)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setConstraints()
        uiGesture()
        
        startButton.delegate = self // 델리게이트
        
        let backItem = UIBarButtonItem()
        backItem.title = "이전"
        navigationItem.backBarButtonItem = backItem
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animateImageFadeIn()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    private func setupViews() {
        view.backgroundColor = .appBackground
        view.addSubview(introImageView)
        view.addSubview(subLabel)
        view.addSubview(subLabel2)
        view.addSubview(subLabel3)
        view.addSubview(startButton)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            introImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            introImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            introImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            introImageView.widthAnchor.constraint(equalToConstant: 430),
            introImageView.heightAnchor.constraint(equalToConstant: 500),
            
            subLabel.topAnchor.constraint(equalTo: introImageView.bottomAnchor, constant: 26),
            subLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            subLabel2.topAnchor.constraint(equalTo: subLabel.bottomAnchor, constant: 10),
            subLabel2.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            subLabel3.topAnchor.constraint(equalTo: subLabel2.bottomAnchor, constant: 35),
            subLabel3.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        originalConstraints = [
            startButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            startButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant:-16),
            startButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            startButton.heightAnchor.constraint(equalToConstant: 51)
        ]
        
        NSLayoutConstraint.activate(originalConstraints)
    }
    
    private func animateImageFadeIn() {
        UIView.animate(withDuration: 3.0, delay: 1.0, options: [.curveEaseInOut], animations: {
            self.introImageView.alpha = 1.0
            self.subLabel.alpha = 1.0
            self.subLabel2.alpha = 1.0
            self.subLabel3.alpha = 1.0
            self.startButton.alpha = 1.0
        }, completion: nil)
    }
    
    private func uiGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleStartTap))
        startButton.addGestureRecognizer(tap)
        startButton.isUserInteractionEnabled = true
        
        
        let backgroundTap = UITapGestureRecognizer(target: self, action: #selector(handleOutsideTap(_:)))
        backgroundTap.cancelsTouchesInView = false
        view.addGestureRecognizer(backgroundTap)
        
    }
    
    @objc private func handleStartTap() {
        guard !isModalExpanded else { return }
        isModalExpanded = true
        
        view.bringSubviewToFront(startButton)
        NSLayoutConstraint.deactivate(originalConstraints)
        
        if modalConstraints.isEmpty {
            modalConstraints = [
                startButton.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                startButton.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                startButton.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                startButton.heightAnchor.constraint(equalToConstant: 320)
            ]
        }
        
        startButton.configure(for: .expanded)
        NSLayoutConstraint.activate(modalConstraints)
        
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping: 0.85,
                       initialSpringVelocity: 0.5,
                       options: [.curveEaseInOut], animations: {
            self.view.layoutIfNeeded()
            self.startButton.layer.cornerRadius = 30
        }, completion: nil)
    }
    
    @objc private func handleOutsideTap(_ gesture: UITapGestureRecognizer) {
        let location = gesture.location(in: view)
        guard isModalExpanded, !startButton.frame.contains(location) else { return }
        
        isModalExpanded = false
        NSLayoutConstraint.deactivate(modalConstraints)
        NSLayoutConstraint.activate(originalConstraints)
        startButton.configure(for: .compact)
        
        UIView.animate(withDuration: 0.4) {
            self.view.layoutIfNeeded()
        }
    }
}


// MARK: - RadiusSquareProtocol Delegate
extension IntroViewController: RadiusSquareDelegate {
    func onExistingRunnerTapped() {
        // 기존 러너 화면으로 이동
        coordinator?.goToLogin()
    }
    
    func onNewRunnerTapped() {
        // 새로운 러너 회원가입 화면으로 이동
        coordinator?.goToAuth()
    }
}
