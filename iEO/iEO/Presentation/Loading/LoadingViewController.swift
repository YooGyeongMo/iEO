//
//  LoadingViewController.swift
//  iEO
//
//  Created by Demian Yoo on 4/24/25.
//

import UIKit
import Lottie


class LoadingViewController: UIViewController {
    weak var coordinator: AppCoordinator?
    private var animationView: LottieAnimationView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .accent
        setupLottie()
        startDelayedTransition()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        animationView?.stop()
        animationView?.removeFromSuperview()
    }
    
    private func setupLottie() {
        
        animationView = LottieAnimationView(name: "loading")
        guard let animationView = animationView else { return }
        
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.play()
        animationView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(animationView)
        
        NSLayoutConstraint.activate ([
            animationView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            animationView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
        ])
        
    }
    
    private func startDelayedTransition() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 10.0) { [weak self] in
            self?.animationView?.stop()
            self?.animationView?.removeFromSuperview()
            self?.coordinator?.goToHome()
        }
    }
    
}
