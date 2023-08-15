//
//  ChatViewModel.swift
//  MovieApp
//
//  Created by mr.root on 6/21/23.
//

import Foundation
import Combine

class ChatViewModel {
    let messagePublisher = PassthroughSubject<[MessageResponse], Never>()
    let userPublisher = PassthroughSubject<[UserResponse], Never>()
    let currentUser = UserDefaultManager.shared.currentUserId
    let reloadData = PassthroughSubject<Void, Never>()
    
    func fetchUser() {
        FirebaseManager.shared.fecthUserData { [weak self] arrays in
            guard let `self` = self else {return}
            let user = arrays.filter { $0.id != self.currentUser}
            self.userPublisher.send(user)
        }
    }
    
    func deMozip() {
    var messageArr = [MessageResponse]()
    
    let arr1 = MessageResponse(text: "a",
                               time: 0,
                               nameSender: "d",
                               idSender: "d",
                               reciveName: "a",
                               idRecive: "d",
                               imageurl: "d")
    
    messageArr.append(arr1)
    messagePublisher.send(messageArr)
    }
}
