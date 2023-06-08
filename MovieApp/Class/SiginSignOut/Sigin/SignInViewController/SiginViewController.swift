//
//  SiginViewController.swift
//  MovieApp
//
//  Created by mr.root on 5/28/23.
//

import UIKit
import Combine

class SiginViewController: BaseViewController {
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var logInButton: UIButton!
    @IBOutlet weak var forgotPasswordButton: UIButton!
    @IBOutlet weak var SignUpButton: UIButton!
    @IBOutlet weak var nameErrorLabel: UILabel!
    @IBOutlet weak var passwordError: UILabel!
    
    private var store = Set<AnyCancellable>()
    private let viewmodel: SigInViewmodel = SigInViewmodel()
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.view.endEditing(true)
    }
    
    override func setupTap() {
        logInButton.addTarget(self, action: #selector(didTapLogIn(_:)), for: .touchUpInside)
        SignUpButton.addTarget(self, action: #selector(didTapLogIn(_:)), for: .touchUpInside)
        userNameTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    
    override func onBind() {
        viewmodel.nameErrorPublisher.assign(to: \.text, on: nameErrorLabel).store(in: &store)
        nameErrorLabel.textColor = .red
        viewmodel.passwordErrorPublisher.assign(to: \.text, on: passwordError).store(in: &store)
        passwordError.textColor = .red
    }
    
    override func setupViewModel() {
        
    }
    //MARK: - ActionButton
    @objc private func didTapLogIn(_ sender: UIButton) {
        if sender == logInButton {
            //Todo here
        }else if sender == SignUpButton {
            //To do here
        }
    }
    
    @objc private func textFieldDidChange(_ sender: UITextField) {
        if sender === userNameTextField {
            viewmodel.namePublisher.send(userNameTextField.text ?? "")
        }else if sender === passwordTextField {
            viewmodel.passWordPublisher.send(passwordTextField.text ?? "")
        }
    }
}
