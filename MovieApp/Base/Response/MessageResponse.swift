//
//  MessageResponse.swift
//  MovieApp
//
//  Created by mr.root on 6/28/23.
//

import Foundation
import UIKit

final class MessageResponse {
    var text: String?
    var time: Double?
    var nameSender: String?
    var senderAvatar: String?
    var idSender: String?
    var reciveName: String?
    var reciverAvatar: String?
    var idRecive: String?
    var imageUrl: String?
    var ratioImage: CGFloat?
    var typeMessage: Int?

    init(text: String? = nil, time: Double? = nil, nameSender: String? = nil, senderAvatar: String? = nil ,idSender: String? = nil, reciveName: String? = nil, reciverAvatar: String? = nil ,idRecive: String? = nil, imageurl: String? = nil, ratioImage: CGFloat? = nil, typeMessage: Int? = nil) {
        self.text = text
        self.time = time
        self.nameSender = nameSender
        self.idSender = idSender
        self.reciveName = reciveName
        self.idRecive = idRecive
        self.imageUrl = imageurl
        self.senderAvatar = senderAvatar
        self.reciverAvatar = reciverAvatar
        self.ratioImage = ratioImage
        self.typeMessage = typeMessage
    }
    
    convenience init(json: [String: Any]) {
        self.init()
        for (key, value) in json {
            switch key {
            case "text":
                self.text = value as? String
            case "time":
                self.time = value as? Double
            case "nameSender":
                self.nameSender = value as? String
            case "senderAvatar":
                self.senderAvatar = value as? String
            case "idSender":
                self.idSender = value as? String
            case "reciveName":
                self.reciveName = value as? String
            case "reciverAvatar":
                self.reciverAvatar = value as? String
            case "idRecive":
                self.idRecive = value as? String
            case "imageUrl":
                self.imageUrl = value as? String
            case "ratioImage":
                self.ratioImage = value as? CGFloat
            case "typeMessage":
                self.typeMessage = value as? Int
            default:
                break
            }
        }
    }
    
    func converToDistionary() -> [String : Any] {
        return  [
            "text": self.text as Any,
            "time": self.time as Any,
            "nameSender": self.nameSender as Any,
            "idSender": self.idSender as Any,
            "reciveName": self.reciveName as Any,
            "idRecive": self.idRecive as Any,
            "imageUrl": self.imageUrl as Any,
            "reciverAvatar": self.reciverAvatar as Any,
            "senderAvatar": self.senderAvatar as Any,
            "ratioImage": self.ratioImage as Any,
            "typeMessage": self.typeMessage as Any
        ]
    }
}
