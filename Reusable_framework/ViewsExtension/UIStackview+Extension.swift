//
//  UIStackview+Extension.swift
//  ARCHECO-BJIT-E-commerce
//
//  Created by Amit Chowdhury on 26/8/20.
//  Copyright © 2020 Archeco. All rights reserved.
//

import UIKit

extension UIStackView {
    func insertSeparator(_ createSeparator: (() -> UIView)) {
        let subviews = self.arrangedSubviews

        for v in subviews {
            self.removeArrangedSubview(v)
        }

        for v in subviews {
            self.addArrangedSubview(v)
            self.addArrangedSubview(createSeparator())
        }

    }

    func separator(color: UIColor, size: CGFloat) {
        self.insertSeparator { () -> UIView in
            let separator = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 200, height: 5.0)))
            separator.heightAnchor.constraint(equalToConstant: 2.0).isActive = true
            separator.widthAnchor.constraint(equalToConstant: 200).isActive = true
            separator.backgroundColor = color
            return separator
        }
    }

    func removeFully(view: UIView) {
        removeArrangedSubview(view)
        view.removeFromSuperview()
    }

    func removeFullyAllArrangedSubviews() {
        arrangedSubviews.forEach { (view) in
            removeFully(view: view)
        }
    }
}
