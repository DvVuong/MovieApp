//
//  BaseViewController.swift
//  MovieApp
//
//  Created by mr.root on 5/28/23.
//

import UIKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTap()
        keyBoardObserver()
        func bindData() {}
        func onBind() {}
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.view.endEditing(true)
    }
    
    func setupUI() {}
    func setupTap() {}
    func setupViewModel() {}
    func bindData() {}
    func onBind() {}
    
    private func keyBoardObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}

extension BaseViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        hideKeyboardWhenTappedAround()
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        hideKeyboardWhenTappedAround()
    }
}


extension BaseViewController {
    @objc func keyBoardWillShow(_ sender: Notification) {
         
    }
    
    @objc func keyBoardWillHide(_ sender: Notification) {
        
    }
}
