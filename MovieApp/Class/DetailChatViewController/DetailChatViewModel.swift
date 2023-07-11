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
    private var arraysMessage = [MessageResponse]()
    init() {
        reciverUserPassthroughSubject.sink(receiveValue: {[weak self] user in
            guard let `self` = self else {return}
            self.reciverUser = user
        })
        .store(in: &store)
    }
    
    func createMessage(_ text: String, messagetye: MessageType) {
        FirebaseManager.shared.createMessage(text, sender: currentUser, reciver: reciverUser ?? UserResponse(), messageType: messagetye)
    }
    
    func fetchMessage() {
        arraysMessage.removeAll()
        FirebaseManager.shared.fecthMessage(self.currentUser, reciver: self.reciverUser ?? UserResponse()) {[weak self] message in
            guard let `self` = self else {return}
            let currentUser = UserDefaultManager.shared.getCurrentUsert()
            let partner = UserDefaultManager.shared.getPartnerUser()
            self.arraysMessage.removeAll()
            for i in message {
                if i.idRecive == currentUser.id ?? "" || i.idRecive == partner.id ?? "" {
                    self.arraysMessage.append(contentsOf: message)
                    self.arraysMessage = self.arraysMessage.sorted {
                        $0.time ?? 0 < $1.time ?? 0
                    }
                }
            }
            self.message.send(self.arraysMessage)
        }
    }
}

