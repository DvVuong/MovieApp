//
//  Extension.swift
//  MovieApp
//
//  Created by mr.root on 5/28/23.
//

import UIKit
import Combine

let kAnimationDuration: Float = 0.3

extension UIButton {
    func conerRadius(with numberRadius: CGFloat) {
        self.layer.cornerRadius = numberRadius
        self.layer.masksToBounds = true
    }
    
    func boderWidth(with numberBoder: CGFloat, color: UIColor? = .black) {
        self.layer.borderWidth = numberBoder
        self.layer.borderColor = color?.cgColor
    }
}

extension UIView {
    func setupBoderWidth(with boderWidth: CGFloat, color: CGColor) {
        self.layer.borderWidth = boderWidth
        self.layer.borderColor = color
    }
    
    func cornerRadius(_ height: CGFloat) {
        self.layer.cornerRadius = height
        self.layer.masksToBounds = true
    }
    
    func cornerRadiusTopLeft() {
        self.layer.cornerRadius = 8
        self.layer.maskedCorners = [.layerMaxXMinYCorner]
    }
    
    func setCornerRadiusAndBorder(topLeftRadius: CGFloat, topRightRadius: CGFloat, bottomRightRadius: CGFloat, bottomLeftRadius: CGFloat) {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: bounds.minX + topLeftRadius, y: bounds.minY))
        
        // Top right corner
        path.addArc(withCenter: CGPoint(x: bounds.maxX - topRightRadius, y: bounds.minY + topRightRadius),
                    radius: topRightRadius,
                    startAngle: CGFloat(-Double.pi / 2),
                    endAngle: 0,
                    clockwise: true)
        
        // Bottom right corner
        path.addArc(withCenter: CGPoint(x: bounds.maxX - bottomRightRadius, y: bounds.maxY - bottomRightRadius),
                    radius: bottomRightRadius,
                    startAngle: 0,
                    endAngle: CGFloat(Double.pi / 2),
                    clockwise: true)
        
        // Bottom left corner
        path.addArc(withCenter: CGPoint(x: bounds.minX + bottomLeftRadius, y: bounds.maxY - bottomLeftRadius),
                    radius: bottomLeftRadius,
                    startAngle: CGFloat(Double.pi / 2),
                    endAngle: CGFloat(Double.pi),
                    clockwise: true)
        
        // Top left corner
        path.addArc(withCenter: CGPoint(x: bounds.minX + topLeftRadius, y: bounds.minY + topLeftRadius),
                    radius: topLeftRadius,
                    startAngle: CGFloat(Double.pi),
                    endAngle: CGFloat(-Double.pi / 2),
                    clockwise: true)
        
        let maskLayer = CAShapeLayer()
        maskLayer.path = path.cgPath
        layer.mask = maskLayer
    }
    
}

extension UILabel {
     func cornerRadiusLabel(_ height: CGFloat) {
         self.layer.cornerRadius = height
         self.layer.masksToBounds = true
    }
}
extension UIViewController {
    func push(_ vc: UIViewController) {
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func pop() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func popToRoot() {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    func popToVC(_ vc: UIViewController) {
        self.navigationController?.popToViewController(vc, animated: true)
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension UIColor {
    static let background = UIColor(named: "background")
    static let defaultTint = UIColor(named: "defaultTint")
    static let cell_background = UIColor(named: "cell_background")

    struct Navigation {
        static let background = UIColor(named: "navigation_background")
    }

    struct TabBar {
        static let itemBackground = UIColor(named: "tabItem_background")
        static let title = UIColor(named: "title")
    }
}

extension UITabBarController {
    func setTabBar(hidden: Bool, animated: Bool) {
           let animationDuration = animated ? kAnimationDuration : 0
        UIView.animate(withDuration: 0.5, animations: {
               var frame = self.tabBar.frame
               frame.origin.y = self.view.frame.height
               if !hidden {
                   frame.origin.y -= frame.height
               } else {
                   let backgroundImageSize = self.tabBar.backgroundImage?.size ?? CGSize.zero
                   let heightDiff: CGFloat = backgroundImageSize.height - frame.height
                   // If background image size is large, tabBar top seem.
                   if heightDiff > 0 {
                       frame.origin.y += heightDiff
                   }
               }
               self.tabBar.frame = frame
           }, completion:nil)
       }
}

extension Dictionary {
    var jsonData: Data? {
        return try? JSONSerialization.data(withJSONObject: self, options: [.prettyPrinted])
    }
    
    func toJson() -> String? {
        if let jsonData = jsonData {
            let jsonString = String(data: jsonData, encoding: .utf8)
            return jsonString
        }
        return nil
    }
}
