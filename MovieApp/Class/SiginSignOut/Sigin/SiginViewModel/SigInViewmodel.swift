//
//  SigInViewmodel.swift
//  MovieApp
//
//  Created by mr.root on 5/28/23.
//

import Foundation
import Combine

class SigInViewmodel {
    let namePublisher = PassthroughSubject<String, Never>()
    let passWordPublisher = PassthroughSubject<String, Never>()
    
    
    //Handel When Error
    let nameErrorPublisher = CurrentValueSubject<String?, Never>("")
    let passwordErrorPublisher = CurrentValueSubject<String?, Never>("")
    private var subscriptions = Set<AnyCancellable>()
    init() {
        namePublisher.map {self.validateName($0)}.sink { [weak self] value in
            guard let `self` = self else { return }
            self.nameErrorPublisher.value = value?.1
            print(value?.1)
        }
        .store(in: &subscriptions)
        passWordPublisher.map {self.validatePassword($0)}.sink { [weak self] value in
            guard let `self` = self else { return }
            self.passwordErrorPublisher.value = value?.1
            print(value?.1)
        }
        .store(in: &subscriptions)
        
    }
    
    private func validateName(_ name: String) -> (Bool, String)? {
        print(name)
        if name.isEmpty {
            return (false, "Name cant emty")
        }
        return (true, "")
    }
    
    private func validatePassword(_ password: String) -> (Bool, String)? {
        print(password)
        do {
            if password.isEmpty {
                return (false, "Name cant emty")
            }else {
                let patter = "(?:(?:(?=.*?[0-9])(?=.*?[-!@#$%&*ˆ+=_])|(?:(?=.*?[0-9])|(?=.*?[A-Z])|(?=.*?[-!@#$%&*ˆ+=_])))|(?=.*?[a-z])(?=.*?[0-9])(?=.*?[-!@#$%&*ˆ+=_]))[A-Za-z0-9-!@#$%&*ˆ+=_]{6,15}"
                let passWordRange = try NSRegularExpression(pattern: patter, options: .caseInsensitive)
                let range = NSRange(location: 0, length: password.count)
                if passWordRange.firstMatch(in: patter, range: range) != nil {
                    return (true, "")
                }else {
                    return (false, "adad")
                }
            }
        }
        catch let error {
            print("vuongdv", error.localizedDescription)
        }
        return (true, "")
    }
}
