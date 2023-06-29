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
    
    func deMozip() {
    var messageArr = [MessageResponse]()
    var userArry = [UserResponse]()
    
    let arr1 = MessageResponse(text: "a",
                               time: 0,
                               nameSender: "d",
                               idSender: "d",
                               reciveName: "a",
                               idRecive: "d",
                               imageurl: "d")
    
    messageArr.append(arr1)
        
        messagePublisher.send(messageArr)
    
    let arr2 = UserResponse(email: "asd",
                            id: "d",
                            userName: "s",
                            active: true,
                            imageUrl: "d")
    userArry.append(arr2)
        userPublisher.send(userArry)
        
    }
}
