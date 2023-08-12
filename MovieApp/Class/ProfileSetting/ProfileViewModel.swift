//
//  ProfileViewModel.swift
//  MovieApp
//
//  Created by BeeTech on 16/06/2023.
//

import Foundation
import Combine

class ProfileViewModel {
    func fetchUser() {
//        FirebaseManager.shared.fecthUserData { [weak self] userResponse in
//            guard let `self` = self else { return }
//            let currentUserID = UserDefaultManager.shared.setCurrentUserID()
//            for i in userResponse {
//                if i.id == currentUserID {
//                    self.userPublisher.send(i)
//                    break
//                }
//            }
//        }
    }
    
    func logoutUser(completion: () -> Void) {
        FirebaseManager.shared.logout {
            let userID = UserDefaultManager.shared.setCurrentUserID()
            FirebaseManager.shared.changeStateForUser(with: userID, isActive: false)
            UserDefaultManager.shared.removeObject(with: UserDefaultContans.idUser)
            completion()
        }
    }
}
