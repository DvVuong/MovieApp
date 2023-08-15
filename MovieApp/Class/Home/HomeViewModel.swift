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

class HomeViewModel: BaseViewModel {
    private var arrays = [Movie]()
    var arrItemsMovie = BehaviorRelay<[Movie]>(value: [])
    var currenPage = 1
    var canLoadMore = BehaviorRelay<Bool>(value: false)
    let userPublisher = PassthroughSubject<UserResponse, Never>()
    
    
    func fetchUser() {
        FirebaseManager.shared.fecthUserData { [weak self] userResponse in
            guard let `self` = self else { return }
            let currentUserID = UserDefaultManager.shared.currentUserId
            for i in userResponse {
                if i.id == currentUserID {
                    self.userPublisher.send(i)
                    UserDefaultManager.shared.currentUser = i
                }else {
                    UserDefaultManager.shared.partnerUser = i
                }
            }
        }
    }
    
    func fetchListMovie() -> Driver<MovieRespone> {
        return APIService.fetchListMovie(with: MovieRespone.self).asDriver(onErrorJustReturn: MovieRespone())
    }
    
    func fetchTopRateMovie() -> Driver<MovieRespone> {
        return APIService.fetchTopRateMovie(with: MovieRespone.self).asDriver(onErrorJustReturn: MovieRespone())
    }
    
    func fetchOnTheAirMovie() -> Driver<MovieRespone> {
        return APIService.getFavoritesMovie(with: MovieRespone.self).asDriver(onErrorJustReturn: MovieRespone())
    }
    
    func fecthTVList() -> Driver<MovieRespone> {
        return APIService.fetchTVList(with: MovieRespone.self).asDriver(onErrorJustReturn: MovieRespone())
    }
    
    func getData() {
        APIService.getwatchChingNowMovie(with: MovieRespone.self, page: currenPage)
            .trackActivity(makeActivityIndicator)
            .subscribe(onNext: { [weak self] items in
                guard let `self` = self else {return}
                
                if (items.page ?? 0) < (items.totalPages ?? 0) {
                    self.canLoadMore.accept(true)
                    self.currenPage += 1
                }
                
                if self.canLoadMore.value == true {
                    self.arrays.append(contentsOf: items.results ?? [])
                }

                self.arrItemsMovie.accept( self.canLoadMore.value ? self.arrays : (items.results ?? []))
                
            }).disposed(by: bag)
    }
}
