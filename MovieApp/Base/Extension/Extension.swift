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
