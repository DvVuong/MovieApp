//
//  ReelsViewModel.swift
//  MovieApp
//
//  Created by mr.root on 8/1/23.
//

import Foundation
import RxSwift
import RxCocoa

class ReelsViewModel {
    
    private let listMovie = BehaviorSubject<[Movie]?>(value: nil)
    
    var listMovieObservable: Observable<[Movie]?> {
        return listMovie.asObservable()
    }
    private var bag = DisposeBag()
    
    init() {}
    
    func fetchUpComingMovie() -> Driver<MovieRespone>{
      return APIService.fecthUpComingMovie(with: MovieRespone.self).asDriver(onErrorJustReturn: MovieRespone())
    }
    
    func fetchListMovie() -> Driver<MovieRespone> {
        return APIService.fetchListMovie(with: MovieRespone.self).asDriver(onErrorJustReturn: MovieRespone())
    }
}
