//
//  HomeViewController.swift
//  iEO
//
//  Created by Demian Yoo on 4/21/25.
//

import UIKit

class HomeViewController: UIViewController {
    
    weak var coordinator: AppCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if UserStorage.verified {
            let formatted = UserStorage.nickname.prefix(1).uppercased() + UserStorage.nickname.dropFirst().lowercased()
            self.view.makeToast("🥳 환영합니다, \(formatted)!", duration: 2.0, position: .center)
            for (key, value) in UserDefaults.standard.dictionaryRepresentation() {
                print("\(key) = \(value)")
            }
            // optional: 토스트 중복 방지용 플래그
            // UserStorage.verified = false
        }
    }
}
