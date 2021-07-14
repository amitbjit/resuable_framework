//
//  UITextView+extension.swift
//  ARCHECO-LightCafe
//
//  Created by Ahsanul Kabir on 22/9/20.
//  Copyright © 2020 Archeco. All rights reserved.
//

import Foundation
import UIKit

extension UITextView{
    func setMinimumLineHeightAndLetterSpcae(lineHeight: CGFloat, with letterSpacing: CGFloat, and font: UIFont?) {
        let text = self.text
        if let text = text {
            let style = NSMutableParagraphStyle()
            style.minimumLineHeight = lineHeight
            style.lineBreakMode = .byTruncatingTail
            let attributes:[NSAttributedString.Key: Any] = [
                .kern: letterSpacing,
                .font:font as Any,
                .paragraphStyle:style]
            self.attributedText = NSMutableAttributedString(string: text, attributes: attributes)
        }
    }
}
