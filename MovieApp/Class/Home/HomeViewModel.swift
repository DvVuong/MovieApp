//
//  HomeViewModel.swift
//  MovieApp
//
//  Created by BeeTech on 13/06/2023.
//

import Foundation
import Combine
import RxSwift
import RxCocoa

class HomeViewModel {
    let userPublisher = PassthroughSubject<UserResponse, Never>()
    func fetchUser() {
        FirebaseManager.shared.fecthUserData { [weak self] userResponse in
            guard let `self` = self else { return }
            let currentUserID = UserDefaultManager.shared.setCurrentUserID()
            for i in userResponse {
                if i.id == currentUserID {
                    self.userPublisher.send(i)
                    UserDefaultManager.shared.setCurrentUser(i)
                }else {
                    UserDefaultManager.shared.setPartnerUser(i)
                }
            }
        }
    }
    
    func fetchListMovie() -> Driver<MovieRespone> {
        return APIService.shared.fetchListMovie(with: MovieRespone.self).asDriver(onErrorJustReturn: MovieRespone())
    }
    
    func fetchTopRateMovie() -> Driver<MovieRespone> {
        return APIService.shared.fetchTopRateMovie(with: MovieRespone.self).asDriver(onErrorJustReturn: MovieRespone())
    }
    
    func fetchOnTheAirMovie() -> Driver<MovieRespone> {
        return APIService.shared.fecthOnTheAir(with: MovieRespone.self).asDriver(onErrorJustReturn: MovieRespone())
    }
}
