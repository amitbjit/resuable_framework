//
//  UIViewExtension.swift
//  Reusable_framework
//
//  Created by BJIT on 2021/07/14.
//

import Foundation
import UIKit

extension UIView {
    /// Helper method to init and setup the view from the Nib.
    func xibSetup() {
        let view = loadFromNib()
        addSubview(view)
        stretch(view: view)
    }
    /// Method to init the view from a Nib.
    ///
    /// - Returns: Optional UIView initialized from the Nib of the same class name.
    func loadFromNib<T: UIView>() -> T {
        let selfType = type(of: self)
        let bundle = Bundle(for: selfType)
        let nibName = String(describing: selfType)
        let nib = UINib(nibName: nibName, bundle: bundle)
        guard let view = nib.instantiate(withOwner: self, options: nil).first as? T else {
            fatalError("Error loading nib with name \(nibName)")
        }
        return view
    }
    /// Stretches the input view to the UIView frame using Auto-layout
    ///
    /// - Parameter view: The view to stretch.
    func stretch(view: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: topAnchor),
            view.leftAnchor.constraint(equalTo: leftAnchor),
            view.rightAnchor.constraint(equalTo: rightAnchor),
            view.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    //MARK:- Add Corner Radious
    func addCornerRadius(_ radius: CGFloat = 4) {
        layer.cornerRadius = radius
        layer.masksToBounds = true
    }
    
    //MARK:- Add Border
    func addBorderLine(width: CGFloat = 1, color: UIColor) {
        layer.borderWidth = width
        layer.borderColor = color.cgColor
    }


    //MARK:-elevated
    public func elevated() {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 3)
        self.layer.shadowOpacity = 0.2
        self.layer.shadowRadius = 4.0
    }
    
    //MARK:- Card View
    public func makeItCard() {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 3)
        self.layer.shadowOpacity = 0.7
        self.layer.cornerRadius = 2.0
    }
    
    //MARK:- View to Circular
    public func makeItCircular (viewPadding : CGFloat = 0.0){
        self.layer.cornerRadius = 0.5 * (self.bounds.size.width+viewPadding)
    }

    //MARK:- Add Shadow
    func addShadow(
       cornerRadius: CGFloat = 16,
       shadowColor: UIColor = UIColor(white: 0.0, alpha: 0.5),
       shadowOffset: CGSize = CGSize(width: 0.0, height: 3.0),
       shadowOpacity: Float = 0.3,
       shadowRadius: CGFloat = 5) {
          layer.cornerRadius = cornerRadius
          layer.shadowColor = shadowColor.cgColor
          layer.shadowOffset = shadowOffset
          layer.shadowOpacity = shadowOpacity
          layer.shadowRadius = shadowRadius
    }

    
    
    //------------------------
    //MARK:- Animation
    func crossDissolve(duration: TimeInterval = 0.25,
                       during animations: @escaping () -> Void,
                       completion: ((Bool) -> Void)? = nil) {
        UIView.transition(with: self,
                          duration: duration,
                          options: .transitionCrossDissolve,
                          animations: animations,
                          completion: completion)
    }

}
