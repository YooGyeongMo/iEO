//
//  UIViewControllerPreview.swift
//  iEO
//
//  Created by Demian Yoo on 4/18/25.
//
import SwiftUI

#if DEBUG
extension UIViewController {
    private struct Preview: UIViewControllerRepresentable {
        let viewController: UIViewController

        func makeUIViewController(context: Context) -> UIViewController {
            return viewController
        }

        func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
    }

    func toPreview() -> some View {
        Preview(viewController: self)
    }
}
#endif
