//
//  DetailChatViewModel.swift
//  MovieApp
//
//  Created by mr.root on 7/5/23.
//

import Foundation
import Combine
import UIKit

class DetailChatViewModel {
    let reciverUserPassthroughSubject = PassthroughSubject<UserResponse, Never>()
    let currentUser = UserDefaultManager.shared.getCurrentUsert()
    var reciverUser: UserResponse?
    var message = CurrentValueSubject<[MessageResponse]?, Never>(nil)
    var imagePublisher = PassthroughSubject<UIImage, Never>()
    var store = Set<AnyCancellable>()
    private var arraysMessage = [MessageResponse]()
    private var image: UIImage? = nil
    
    init() {
        reciverUserPassthroughSubject.sink(receiveValue: {[weak self] user in
            guard let `self` = self else {return}
            self.reciverUser = user
        })
        .store(in: &store)
        
        imagePublisher.sink(receiveValue: {[weak self] image in
            guard let `self` = self else {return}
            self.image = image
        }).store(in: &store)
    }
    
    func createMessage(_ text: String, messagetye: MessageType) {
        FirebaseManager.shared.createMessage(text, sender: currentUser, reciver: reciverUser ?? UserResponse(), messageType: messagetye)
    }
    
    func fetchMessage() {
        FirebaseManager.shared.fecthMessage(self.currentUser, reciver: self.reciverUser ?? UserResponse()) {[weak self] message in
            guard let `self` = self else {return}
            self.message.send(message)
        }
    }
    
    func createMessgaeWithImage(with image: UIImage, messageType: MessageType) {
        
        let currentUser = UserDefaultManager.shared.getCurrentUsert()
        let partner = UserDefaultManager.shared.getPartnerUser()
        FirebaseManager.shared.createMessageWithImage(with: image, sender: currentUser, reciver: partner, messageType: messageType)
    }
    
    func getItem() -> Int {
        return arraysMessage.count
    }
}

