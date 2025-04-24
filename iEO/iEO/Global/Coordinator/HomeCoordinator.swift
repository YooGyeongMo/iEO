//
//  HomeCoordinator.swift
//  iEO
//
//  Created by Demian Yoo on 4/24/25.
//

import UIKit

class HomeCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    
    func start() {
        let homeVC = HomeViewController()
        homeVC.coordinator = self
        
        // 🎯 전환 애니메이션 추가
        let transition = CATransition()
        transition.duration = 0.4
        transition.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        transition.type = .push
        transition.subtype = .fromRight
        
        navigationController.view.layer.add(transition, forKey: kCATransition)
        
        // 🎯 루트 교체는 그대로
        navigationController.setViewControllers([homeVC], animated: false)
        navigationController.setNavigationBarHidden(false, animated: false)
    }
}
