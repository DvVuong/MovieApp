//
//  SigInViewmodel.swift
//  MovieApp
//
//  Created by mr.root on 5/28/23.
//

import Foundation
import Combine
final class RegisterViewModel {
    
    var onNameErrorListener: ((String?) -> Void)?
    
    // publsher
    let nameErrorPublisher = CurrentValueSubject<String?, Never>("")
    let passErrorPublisher = CurrentValueSubject<String?, Never>("")
    let emailErrorPublisher = CurrentValueSubject<String?, Never>("")
    //let massagerErrorPublisher = CurrentValueSubject<String?, Never>(nil)
   
   // Pubsher validate
    let usernamePublisher = PassthroughSubject<String, Never>()
    let passwordPublisher = PassthroughSubject<String, Never>()
    let emailPublisher = PassthroughSubject<String, Never>()
    
    private var subscriptions = Set<AnyCancellable>()
    
    init() {

        usernamePublisher.map{self.validUserName($0) }.sink { valiPair in
            self.nameErrorPublisher.value = valiPair.message
        }.store(in: &subscriptions)
        
        passwordPublisher.map {self.validPassword($0)}.sink { valPair in
            self.passErrorPublisher.value = valPair.1
        }.store(in: &subscriptions)
        
        emailPublisher.map {self.validEmail($0)}.sink { valPair in
            self.emailErrorPublisher.value = valPair.1
        }.store(in: &subscriptions)
    }
    
    func resgisterAccount(with email: String, password: String, username: String , completion: @escaping (Bool) -> Void) {
        FirebaseManager.shared.resgiterAccount(with: email, password: password) { authDataResult, error in
            guard authDataResult == nil else {
                FirebaseManager.shared.createAccountForstorage(authDataResult?.user.email ?? "", userName: username, id: authDataResult?.user.uid ?? "")
                completion(true)
                return
            }
            completion(false)
        }
    }
    
    func logInAccount(with email: String, password: String, completion: @escaping (Bool) -> Void) {
        FirebaseManager.shared.loginAccount(with: email, password: password) { authDataResult, error in
            guard authDataResult == nil else  {
                completion(true)
                return
            }
            completion(false)
        }
    }
    
    //MARK: Valida
    private func validUserName(_ username: String) -> (isValid: Bool, message: String?) {
        if username.isEmpty {
            return (false, L10n.userNameEmty)
        }
        return (true, nil)
    }
    private func validEmail(_ email: String) -> (Bool, String?) {
        if email.isEmpty {
            return (false, L10n.emailEmty)
        }
        if !isEmail(email) {
            return (false, L10n.emailNotvalid)
        }
        return (true , nil)
    }
    private func validPassword(_ password: String) -> (Bool, String?) {
        if password.isEmpty {
            return (false, L10n.passwordCantEmty)
        }
        if password.contains(" ") {
            return (false, L10n.passwordMustNotContainSpaces )
        }
        if password.count < 8  {
            return (false, L10n.passwordWeak)
        }
        return (true, nil)
    }

    private func isEmail(_ text: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: text)
    }
}
