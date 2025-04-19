//
//  LaunchViewController.swift
//  iEO
//
//  Created by Demian Yoo on 4/17/25.
//

import UIKit

final class LaunchViewController: UIViewController {
    
    weak var coordinator: AppCoordinator?
    
    // MARK: - UI Properties
    
    private let logoImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "appLogo"))
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let logoLabelView: UILabel = {
        let label = UILabel()
        label.text = "\"마음의 수면을 깨우는 순간\""
        label.font = .launchLabel
        label.textColor = .accent
        label.textAlignment = .center
        label.alpha = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let launchWaveView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "launchWave"))
        imageView.contentMode = .scaleToFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
    
    // 뷰가 완전히 보이고나서
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animateViews()
    }
    
    
    // MARK: - Setup
    
    private func setupViews() {
        view.backgroundColor = .appBackground
        view.addSubview(logoImageView)
        view.addSubview(logoLabelView)
        view.addSubview(launchWaveView)
    }
    
    private func setupConstraints() {
        
        
        NSLayoutConstraint.activate([
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
            logoImageView.widthAnchor.constraint(equalToConstant: 60),
            logoImageView.heightAnchor.constraint(equalToConstant: 90),
            
            
            logoLabelView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoLabelView.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 120),
            
            launchWaveView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            launchWaveView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            launchWaveView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            launchWaveView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            launchWaveView.heightAnchor.constraint(equalToConstant:200)
            
        ])
    }
    
    //MARK: - Animation
    
    private func animateViews() {
        UIView.animate(withDuration: 1.0, delay: 0.5, animations: {
            self.logoLabelView.alpha = 1.0
        }) { [weak self] _ in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                self?.coordinator?.showIntro()
            }
        }
    }
}
