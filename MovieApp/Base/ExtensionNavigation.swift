//
//  ExtensionNavigation.swift
//  MovieApp
//
//  Created by BeeTech on 09/06/2023.
//

import UIKit
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
