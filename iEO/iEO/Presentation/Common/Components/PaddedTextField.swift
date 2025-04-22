//
//  PaddedTextField.swift
//  iEO
//
//  Created by Demian Yoo on 4/21/25.
//

import UIKit

final class PaddedTextField: UITextField {
    private let padding = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: padding)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: padding)
    }

    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: padding)
    }
}
