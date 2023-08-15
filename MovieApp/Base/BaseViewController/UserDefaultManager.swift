//
//  UserDefaultManager.swift
//  MovieApp
//
//  Created by BeeTech on 13/06/2023.
//

import Foundation
import SwiftUI

class UserDefaultContans {
    static let idUser = "UserID"
    static let idCurrentUser = "CurrentUserID"
    static let curentUser = "CurrentUser"
    static let partnerUser = "PartnerUser"
    static let favoritesMovie = "FavoritesMovie"
}

class UserDefaultManager {
    static let shared = UserDefaultManager()
    private let _idUser = "UserID"
    private let _idCurrentUSer = "CurrentUserID"
    private let _curentUser = "CurrentUser"
    private let _partnerUser = "PartnerUser"
    private let _FavoritesMovie = "FavoritesMovie"
    
    var idUser: String {
        set {
            UserDefaults.standard.set(newValue, forKey: UserDefaultContans.idUser)
        }
        
        get {
            return UserDefaults.standard.string(forKey: UserDefaultContans.idUser) ?? ""
        }
    }
    
    var currentUserId: String {
        set {
            UserDefaults.standard.set(newValue, forKey: UserDefaultContans.idCurrentUser)
        }
        get {
            return UserDefaults.standard.string(forKey: UserDefaultContans.idCurrentUser) ?? ""
        }
    }
    
    var currentUser: UserResponse? {
        set {
            if let newValue = newValue {
                setObjectToUserDefault(with: newValue, forkey: UserDefaultContans.curentUser)
            }
        }
        
        get {
            guard let object  = getObjecFormUserDefault(with: UserResponse.self, key: UserDefaultContans.curentUser) else {return nil}
            return object
        }
    }
    
    
    var partnerUser: UserResponse? {
        set {
            if let newValue = newValue {
                setObjectToUserDefault(with: newValue, forkey: UserDefaultContans.partnerUser)
            }
        }
        
        get {
            guard let object  = getObjecFormUserDefault(with: UserResponse.self, key: UserDefaultContans.partnerUser) else {return nil}
            return object
        }
    }
    
    var favoritesMovie: Movie? {
        set {
            if let newValue = newValue {
                setObjectToUserDefault(with: newValue, forkey: UserDefaultContans.favoritesMovie)
            }
        }
        
        get {
            guard let object  = getObjecFormUserDefault(with: Movie.self, key: UserDefaultContans.favoritesMovie) else {return nil}
            return object
        }
    }

    //Remove Object
    func removeObject(with key: String) {
        UserDefaults.standard.removeObject(forKey: key)
    }
    
    func setObjectToUserDefault<T: Codable>(with object: T, forkey key: String) {
        do {
            let encoder = try PropertyListEncoder().encode(object)
            UserDefaults.standard.set(encoder, forKey: key)
        }
        catch (let error) {
            print("vuongdv error: \(error)")
        }
    }
    
    func getObjecFormUserDefault<T: Codable>(with object: T.Type, key: String) -> T? {
        do {
            let data = UserDefaults.standard.value(forKey: key) as? Data ?? Data()
            let object = try PropertyListDecoder().decode(object.self, from: data)
            return object
        }
        catch (let error) {
            print("vuongdv error: \(error)")
        }
        return nil
    }
}
