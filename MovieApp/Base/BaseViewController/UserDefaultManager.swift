//
//  UserDefaultManager.swift
//  MovieApp
//
//  Created by BeeTech on 13/06/2023.
//

import Foundation
import SwiftUI
class UserDefaultManager {
    static let shared = UserDefaultManager()
    private let _idUser = "UserID"
    private let _idCurrentUSer = "CurrentUserID"
    private let _curentUser = "CurrentUser"
    private let _partnerUser = "PartnerUser"
    private let _FavoritesMovie = "FavoritesMovie"
    
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
    
    func setCurrentUser(_ currentUser: UserResponse) {
        do {
            let encoderData = try PropertyListEncoder().encode(currentUser)
            UserDefaults.standard.set(encoderData, forKey: _curentUser)
        }
        catch (let error) {
            print("vuongdv", error.localizedDescription)
        }
    }
    
    func getCurrentUsert() -> UserResponse {
        do {
            let data = UserDefaults.standard.value(forKey: _curentUser) as! Data
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
            UserDefaults.standard.set(encoderData, forKey: _partnerUser)
        }
        catch (let error) {
            print("vuongdv", error.localizedDescription)
        }
    }
    
    func getPartnerUser()  -> UserResponse {
        do {
            let data = UserDefaults.standard.value(forKey: _partnerUser) as! Data
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
            UserDefaults.standard.set(encoderData, forKey: _FavoritesMovie)
        }
        catch (let error){
            print("vuongdv", error.localizedDescription)
        }
    }
    func getFavoritesMovie() -> Movie? {
        do {
            let data = UserDefaults.standard.value(forKey: _FavoritesMovie) as? Data ?? Data()
            let objc = try PropertyListDecoder().decode(Movie.self, from: data)
            return objc
        }
        catch (let error) {
            print("vuongdv", error.localizedDescription)
        }
        return nil
    }
}
