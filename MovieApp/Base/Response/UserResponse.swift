//
//  UserResponse.swift
//  MovieApp
//
//  Created by BeeTech on 12/06/2023.
//

import Foundation

class UserResponse: Codable {
    var email: String?
    var id: String?
    var userName: String?
    var active: Bool?
    var imageUrl: String?
    
    init(email: String? = nil, id: String? = nil, userName: String? = nil, active: Bool? = nil, imageUrl: String? = nil) {
        self.email = email
        self.id = id
        self.userName = userName
        self.active = active
        self.imageUrl = imageUrl
    }
    
    convenience init (json: [String: Any]) {
        self.init()
        for (key, value) in json {
            switch key {
            case "id":
                let wrapValue = value as? String
                self.id = wrapValue
            case "email":
                let wrapValue = value as? String
                self.email = wrapValue
            case "userName":
                let wrapValue = value as? String
                self.userName = wrapValue
            case "active":
                let wrapValue = value as? Bool
                self.active = wrapValue
            case "imageUrl":
                let wrapValue = value as? String
                self.imageUrl = wrapValue
            default:
                break
            }
        }
    }
    
    func converToDictionary() -> [String: Any] {
        return [
            "id" : self.id,
            "email" : self.email,
            "userName" : self.userName,
            "active": self.active
        ] as [String: Any]
    }
}
