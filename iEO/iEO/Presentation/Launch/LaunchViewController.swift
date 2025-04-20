//
//  LaunchViewController.swift
//  iEO
//
//  Created by Demian Yoo on 4/17/25.
//

import UIKit

class LaunchViewController: UIViewController {
    
    weak var coordinator: AppCoordinator?
    
    // MARK: - UI Properties
    
    private let logoImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "appLogo"))
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
    
    
    // MARK: - Setup
    
    private func setupViews() {
        view.backgroundColor = .appBackground
        view.addSubview(logoImageView)
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 120),
            logoImageView.widthAnchor.constraint(equalToConstant: 150),
            logoImageView.heightAnchor.constraint(equalToConstant: 80),
        ])
    }
    
    
}
