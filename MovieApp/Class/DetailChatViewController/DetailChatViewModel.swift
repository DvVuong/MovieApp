//
//  DetailChatViewModel.swift
//  MovieApp
//
//  Created by mr.root on 7/5/23.
//

import Foundation
import Combine

class DetailChatViewModel {
    let reciverUserPassthroughSubject = PassthroughSubject<UserResponse, Never>()
    let currentUser = UserDefaultManager.shared.getCurrentUsert()
    var reciverUser: UserResponse?
    var store = Set<AnyCancellable>()
    init() {
        reciverUserPassthroughSubject.sink(receiveValue: {[weak self] user in
            guard let `self` = self else {return}
            self.reciverUser = user
        })
        .store(in: &store)
    }
    
    func createMessage(_ text: String) {
        FirebaseManager.shared.createMessage(text, sender: currentUser, reciver: reciverUser ?? UserResponse())
    }
}

