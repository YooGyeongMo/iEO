//
//  RadiusSquare.swift
//  iEO
//
//  Created by Demian Yoo on 4/20/25.
//

import UIKit

class RadiusSquare: UIView {
    
    private var currentConstraints: [NSLayoutConstraint] = []
    weak var delegate: RadiusSquareDelegate?  // 델리게이트
    
    private let label: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textAlignment = .center
        label.font = .launchLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let subButtonView: UIView = {
        let view = UIView()
        view.backgroundColor = .appBackground
        view.layer.cornerRadius = 25
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let subButtonLabel: UILabel = {
        let label = UILabel()
        label.text = "기존 러너 로그인"  // 원하는 텍스트로 교체 가능
        label.font = .launchLabel
        label.textColor = .accent
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let subButtonView2: UIView = {
        let view = UIView()
        view.backgroundColor = .appBackground
        view.layer.cornerRadius = 25
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let subButtonLabel2: UILabel = {
        let label = UILabel()
        label.text = "새로운 러너 회원가입"  // 원하는 텍스트로 교체 가능
        label.font = .launchLabel
        label.textColor = .accent
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    enum ButtonState {
        case compact
        case expanded
    }
    
    init(title: String, textColor: UIColor) {
        super.init(frame: .zero)
        label.text = title
        label.textColor = textColor
        setupView()
        configure(for: .compact)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    @objc private func existingRunnerTapped() {
        delegate?.onExistingRunnerTapped()
    }
    
    @objc private func newRunnerTapped() {
        delegate?.onNewRunnerTapped()
    }
    
    private func setupView() {
        backgroundColor = .accent
        layer.cornerRadius = 25
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(label)
        addSubview(subButtonView)
        addSubview(subButtonView2)
        subButtonView.addSubview(subButtonLabel)
        subButtonView2.addSubview(subButtonLabel2)
        subButtonView.isHidden = true
        subButtonView2.isHidden = true
        
        let tap1 = UITapGestureRecognizer(target: self, action: #selector(existingRunnerTapped))
        let tap2 = UITapGestureRecognizer(target: self, action: #selector(newRunnerTapped))
        subButtonView.addGestureRecognizer(tap1)
        subButtonView2.addGestureRecognizer(tap2)
        
        subButtonView.isUserInteractionEnabled = true
        subButtonView2.isUserInteractionEnabled = true
        
        let existingTap = UITapGestureRecognizer(target: self, action: #selector(existingRunnerTapped))
        subButtonView.addGestureRecognizer(existingTap)
        
        let newTap = UITapGestureRecognizer(target: self, action: #selector(newRunnerTapped))
        subButtonView2.addGestureRecognizer(newTap)
    }
    
    func configure(for state: ButtonState) {
        NSLayoutConstraint.deactivate(currentConstraints)
        subButtonView.isHidden = (state == .compact)
        subButtonView2.isHidden = (state == .compact)
        
        switch state {
        case .compact:
            label.textAlignment = .center
            label.font = .launchLabel
            layer.cornerRadius = 25
            currentConstraints = [
                label.centerXAnchor.constraint(equalTo: centerXAnchor),
                label.centerYAnchor.constraint(equalTo: centerYAnchor)
            ]
        case .expanded:
            label.textAlignment = .center
            label.font = .launchLabel
            currentConstraints = [
                label.topAnchor.constraint(equalTo: topAnchor, constant: 10),
                label.centerXAnchor.constraint(equalTo: centerXAnchor),
                
                subButtonView.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 55),
                subButtonView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
                subButtonView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
                subButtonView.heightAnchor.constraint(equalToConstant: 51),
                
                subButtonLabel.centerXAnchor.constraint(equalTo: subButtonView.centerXAnchor),
                subButtonLabel.centerYAnchor.constraint(equalTo: subButtonView.centerYAnchor),
                
                subButtonView2.topAnchor.constraint(equalTo: subButtonView.bottomAnchor, constant:40),
                subButtonView2.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
                subButtonView2.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
                subButtonView2.heightAnchor.constraint(equalToConstant: 51),
                
                subButtonLabel2.centerXAnchor.constraint(equalTo: subButtonView2.centerXAnchor),
                subButtonLabel2.centerYAnchor.constraint(equalTo: subButtonView2.centerYAnchor),
                
            ]
        }
        
        NSLayoutConstraint.activate(currentConstraints)
    }
}


