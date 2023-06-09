//
//  SiginViewController.swift
//  MovieApp
//
//  Created by mr.root on 5/28/23.
//

import UIKit
import Combine
import CoreData

class RegisterController: BaseViewController {
    @IBOutlet weak var userNameTextFiled: UITextField!
    @IBOutlet weak var passwordTextFiled: UITextField!
    @IBOutlet weak var btLogin: UIButton!
    @IBOutlet weak var nameError: UILabel!
    @IBOutlet weak var passworkError: UILabel!
    @IBOutlet weak var emailTextFiled: UITextField!
    @IBOutlet weak var emailError: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    
    private var subscriptions = Set<AnyCancellable>()
    private var viewModel = RegisterViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        onBind()
        setupBtLogin()
    }
    override func setupUI() {
        emailTextFiled.delegate = self
        passwordTextFiled.delegate = self
        userNameTextFiled.addTarget(self, action: #selector(didChangeTextFiled(_:)), for: .editingChanged)
        passwordTextFiled.addTarget(self, action: #selector(didChangeTextFiled(_:)), for: .editingChanged)
        emailTextFiled.addTarget(self, action: #selector(didChangeTextFiled(_:)), for: .editingChanged)
        nameError.textColor = .red
        nameError.isHidden = true
        passworkError.isHidden = true
        passworkError.textColor = .red
        emailError.isHidden = true
        emailError.textColor = .red
    }
    
    override func onBind() {
        viewModel.nameErrorPublisher.assign(to: \.text, on: nameError).store(in: &subscriptions)
        nameError.isHidden = false
        viewModel.emailErrorPublisher.assign(to: \.text, on: emailError).store(in: &subscriptions)
        emailError.isHidden = false
        viewModel.passErrorPublisher.assign(to: \.text, on: passworkError).store(in: &subscriptions)
        passworkError.isHidden = false
        // Button
//        Publishers.CombineLatest3(viewModel.nameErrorPublisher.map { $0 == nil },
//                                  viewModel.passErrorPublisher.map { $0 == nil },
//                                  viewModel.emailErrorPublisher.map { $0 == nil })
//        .map { $0.0 && $0.1 && $0.2 }
//        .assign(to: \.isEnabled, on: btLogin)
//        .store(in: &subscriptions)
        Publishers.CombineLatest(viewModel.emailErrorPublisher.map {$0 == nil},
                                 viewModel.passErrorPublisher.map {$0 == nil})
        .map { $0.0 && $0.1}
        .assign(to: \.isEnabled, on: btLogin)
        .store(in: &subscriptions)
    }
    
    
    
    @objc private func didChangeTextFiled(_ textField: UITextField) {
        if textField === userNameTextFiled {
            viewModel.usernamePublisher.send(textField.text ?? "")
        }
        else if textField === passwordTextFiled {
             viewModel.passwordPublisher.send(textField.text ?? "")
        }
       else if textField === emailTextFiled {
           viewModel.emailPublisher.send(textField.text ?? "")
        }
    }
    private func setupBtLogin() {
        btLogin.isEnabled = false
        btLogin.addTarget(self, action: #selector(didTapLogin), for: .touchUpInside)
    }
   
    @objc private func didTapLogin() {
        let email = emailTextFiled.text ?? ""
        let password = passwordTextFiled.text ?? ""
        //Login
        viewModel.resgisterAccount(with: email, password: password) { bool in
            if bool {
                ToastUtil.showToast(with: L10n.resgiterSuccess)
            }else {
                ToastUtil.showToast(with: L10n.resgiterFailure)
            }
        }
    }
}
