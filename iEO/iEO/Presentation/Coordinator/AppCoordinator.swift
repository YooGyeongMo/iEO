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
    
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let launchVC = LaunchViewController()
        launchVC.coordinator = self
        window.rootViewController = launchVC
    }
}
