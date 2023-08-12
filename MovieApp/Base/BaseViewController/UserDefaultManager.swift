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
    
    func getIdUser(_ id: String) {
        UserDefaults.standard.set(id, forKey: UserDefaultContans.idUser)
    }
    
    func setIdUser() -> String {
        return UserDefaults.standard.string(forKey: UserDefaultContans.idUser) ?? ""
    }
    
    func getCurrentUserID(_ id: String) {
        UserDefaults.standard.set(id, forKey: UserDefaultContans.idCurrentUser)
    }
    
    func setCurrentUserID() -> String {
        return UserDefaults.standard.string(forKey: UserDefaultContans.idCurrentUser) ?? ""
    }
    
    func setCurrentUser(_ currentUser: UserResponse) {
        do {
            let encoderData = try PropertyListEncoder().encode(currentUser)
            UserDefaults.standard.set(encoderData, forKey: UserDefaultContans.curentUser)
        }
        catch (let error) {
            print("vuongdv", error.localizedDescription)
        }
    }
    
    func getCurrentUsert() -> UserResponse {
        do {
            let data = UserDefaults.standard.value(forKey: UserDefaultContans.curentUser) as! Data
            let objc = try PropertyListDecoder().decode(UserResponse.self, from: data)
            return objc
        }
        catch (let error){
            print("vuongdv", error.localizedDescription)
        }
        return UserResponse()
    }
    
    func setPartnerUser(_ partnerUser: UserResponse) {
        do {
            let encoderData = try PropertyListEncoder().encode(partnerUser)
            UserDefaults.standard.set(encoderData, forKey: UserDefaultContans.partnerUser)
        }
        catch (let error) {
            print("vuongdv", error.localizedDescription)
        }
    }
    
    func getPartnerUser()  -> UserResponse {
        do {
            let data = UserDefaults.standard.value(forKey: UserDefaultContans.partnerUser) as! Data
            let objc = try PropertyListDecoder().decode(UserResponse.self, from: data)
            return objc
        }
        catch (let error) {
            print("vuongdv", error.localizedDescription)
        }
        return UserResponse()
    }
    
    func setFavoritesMovie(with movie: Movie) {
        do {
            let encoderData = try PropertyListEncoder().encode(movie)
            UserDefaults.standard.set(encoderData, forKey: UserDefaultContans.favoritesMovie)
        }
        catch (let error){
            print("vuongdv", error.localizedDescription)
        }
    }
    func getFavoritesMovie() -> Movie? {
        do {
            let data = UserDefaults.standard.value(forKey: UserDefaultContans.favoritesMovie) as? Data ?? Data()
            let objc = try PropertyListDecoder().decode(Movie.self, from: data)
            return objc
        }
        catch (let error) {
            print("vuongdv", error.localizedDescription)
        }
        return nil
    }
    
    //Remove Object
    
    func removeObject(with key: String) {
        UserDefaults.standard.removeObject(forKey: key)
    }
}
