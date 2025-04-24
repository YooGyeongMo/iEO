//
//  HomeViewController.swift
//  iEO
//
//  Created by Demian Yoo on 4/21/25.
//

import UIKit
import SwiftUI

class HomeViewController: UIViewController {
    
    weak var coordinator: HomeCoordinator?
    
//    private
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .accent
        title = "러너 위키"
        
        showHomeView()
            // optional: 토스트 중복 방지용 플래그
            // UserStorage.verified = false
        }
    
    private func showHomeView() {
        if UserStorage.verified {
            let formatted = UserStorage.nickname.prefix(1).uppercased() + UserStorage.nickname.dropFirst().lowercased()
            self.view.makeToast("🥳 환영합니다, \(formatted)!", duration: 2.0, position: .center)
            for (key, value) in UserDefaults.standard.dictionaryRepresentation() {
                print("\(key) = \(value)")
            }
        }
    }
    
    private func setupViews() {
        
    }
}


struct PreView: PreviewProvider {
    static var previews: some View {
        // Preview를 보고자 하는 ViewController를 넣으면 됩니다.
        HomeViewController().toPreview()
    }
}
