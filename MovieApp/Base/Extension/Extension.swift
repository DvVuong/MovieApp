//
//  Extension.swift
//  MovieApp
//
//  Created by mr.root on 5/28/23.
//

import UIKit
import Combine

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
    func cornerRadius(_ height: CGFloat) {
        self.layer.cornerRadius = height
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
