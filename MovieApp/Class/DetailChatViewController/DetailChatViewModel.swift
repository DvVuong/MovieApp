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
    var message = CurrentValueSubject<[MessageResponse]?, Never>(nil)
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
    
    func fetchMessage() {
        FirebaseManager.shared.fecthMessage(self.currentUser, reciver: self.reciverUser ?? UserResponse()) {[weak self] message in
            guard let `self` = self else {return}
            print("vuongdv Begin Fetch message")
            self.message.send(message)
        }
    }
    
//    func fetchMessage() -> Future<[MessageResponse], Never> {
//        return Future {[weak self]  promise in
//            guard let `self` = self else {return}
//            FirebaseManager.shared.fecthMessage(self.currentUser, reciver: self.reciverUser ?? UserResponse()) { message in
//                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//                    print("vuongdv Begin Fetch message")
//                    promise(.success(message))
//                }
//            }
//        }
//    }
}

