//
//  UserResponse.swift
//  MovieApp
//
//  Created by BeeTech on 12/06/2023.
//

import Foundation

class UserResponse {
    var email: String?
    var id: String?
    var userName: String?
    
    init(email: String? = nil, id: String? = nil, userName: String? = nil) {
        self.email = email
        self.id = id
        self.userName = userName
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
        ] as [String: Any]
    }
}
