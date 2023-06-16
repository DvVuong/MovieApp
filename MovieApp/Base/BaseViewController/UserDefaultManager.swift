//
//  UserDefaultManager.swift
//  MovieApp
//
//  Created by BeeTech on 13/06/2023.
//

import Foundation
class UserDefaultManager {
    static let shared = UserDefaultManager()
    private let _idUser = "UserID"
    private let _idCurrentUSer = "CurrentUserID"
    
    func getIdUser(_ id: String) {
        UserDefaults.standard.set(id, forKey: _idUser)
    }
    
    func setIdUser() -> String {
        return UserDefaults.standard.string(forKey: _idUser) ?? ""
    }
    
    func getCurrentUserID(_ id: String) {
        UserDefaults.standard.set(id, forKey: _idCurrentUSer)
    }
    func setCurrentUserID() -> String {
        return UserDefaults.standard.string(forKey: _idCurrentUSer) ?? ""
    }
    
}
