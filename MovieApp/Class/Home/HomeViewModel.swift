//
//  HomeViewModel.swift
//  MovieApp
//
//  Created by BeeTech on 13/06/2023.
//

import Foundation
import Combine

class HomeViewModel {
    let userPublisher = PassthroughSubject<UserResponse, Never>()
    
    func fetchUser() {
        FirebaseManager.shared.fecthUserData { [weak self] userResponse in
            guard let `self` = self else { return }
            self.userPublisher.send(userResponse)
        }
    }
}
