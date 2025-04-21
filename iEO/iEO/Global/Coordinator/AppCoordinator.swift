//
//  AppCoordinator.swift
//  iEO
//
//  Created by Demian Yoo on 4/17/25.
//

import UIKit

class AppCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    private let window: UIWindow
    private let navigationController: UINavigationController
    
    
    init(window: UIWindow) {
        self.window = window
        self.navigationController = UINavigationController()
        
        // 기본 네비게이션 바 appearance 설정
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .accent
        appearance.shadowColor = .clear
        appearance.titleTextAttributes = [.foregroundColor: UIColor.textPrimary]
        navigationController.navigationBar.standardAppearance = appearance
        navigationController.navigationBar.scrollEdgeAppearance = appearance
        navigationController.navigationBar.compactAppearance = appearance
        navigationController.navigationBar.tintColor = .textPrimary // back 버튼 색상
        
    }
    
    func start() {
        showLaunch()
        window.rootViewController = navigationController
    }
    
    private func showLaunch() {
        let launchVC = LaunchViewController()
        launchVC.coordinator = self
        navigationController.setViewControllers( [launchVC], animated: false)
        navigationController.setNavigationBarHidden(true, animated: false)
    }
    
    func showIntro() {
        let introVC = IntroViewController()
        introVC.coordinator = self
        // 🎯 CATransition 만들기
        let transition = CATransition()
        transition.duration = 1.0
        transition.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        transition.type = .push
        transition.subtype = .fromRight  // ← 왼쪽에서 오른쪽으로!
        
        // 🎯 네비게이션 컨트롤러 뷰에 애니메이션 추가
        navigationController.view.layer.add(transition, forKey: kCATransition)
        // 🎯 IntroViewController push (애니메이션은 false로 설정)
        navigationController.pushViewController(introVC, animated: false)
        navigationController.setNavigationBarHidden(true, animated: false)
        
    }
    
    func goToLogin() {
        let loginVC = LoginViewController()
        loginVC.coordinator = self
        navigationController.pushViewController(loginVC, animated: true)
        navigationController.setNavigationBarHidden(false, animated: true)
    }
    
    func goToAuth() {
        let authVC = SignUpAuthViewController()
        authVC.coordinator = self
        navigationController.pushViewController(authVC, animated: true)
        navigationController.setNavigationBarHidden(false, animated: true)
    }
    func popToBack() {
        navigationController.popViewController(animated: true)
    }
    
    
}
