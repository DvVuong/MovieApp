//
//  LoginViewController.swift
//  MovieApp
//
//  Created by BeeTech on 09/06/2023.
//

import UIKit
import Combine

class LoginViewController: BaseViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var logInButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    
    private var subscription = Set<AnyCancellable>()
    let viewModel = RegisterViewModel()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func setupUI() {
        emailTextField.text = "long@gmail.com"
        passwordTextField.text = "12345678"
    }
    override func setupTap() {
        logInButton.addTarget(self, action: #selector(didTap(_:)), for: .touchUpInside)
        registerButton.addTarget(self, action: #selector(didTap(_:)), for: .touchUpInside)
        
    }
    
    @objc func didTap(_ sender: UIButton) {
        if sender === logInButton {
            logIn()
        }else if sender === registerButton {
            let vc = RegisterController()
            vc.hidesBottomBarWhenPushed = true
            push(vc)
        }
    }
    
    private func logIn() {
        let email = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        if email == "" {
            ToastUtil.showToast(with: L10n.emailEmty)
            return
        } else if password == "" {
            ToastUtil.showToast(with: L10n.passwordCantEmty)
            return
        }else {
            viewModel.logInAccount(with: email, password: password) { bool in
                if bool {
                    UserDefaults.standard.set(bool, forKey: "Login")
                    ToastUtil.showToast(with: L10n.logInSuccess)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
                        guard let `self` = self else { return }
                        let tabbar = TabBarController()
                        (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first?.rootViewController =
                        tabbar
                        let vc = HomeViewController()
                        self.push(vc)
                    }
                }else {
                    UserDefaults.standard.set(bool, forKey: "Login")
                    ToastUtil.showToast(with: L10n.loginFailure)
                }
            }
        }
    }
}
