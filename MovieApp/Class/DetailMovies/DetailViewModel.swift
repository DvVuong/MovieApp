//
//  DetailViewModel.swift
//  MovieApp
//
//  Created by mr.root on 7/27/23.
//

import Foundation
import RxSwift
import RxCocoa
import UIKit

class DetailViewModel {
    let movieItem = PublishSubject<Movie>()
    let indexPublisher = PublishSubject<Int>()
    
    var movieObservable: Observable<Movie> {
        return moveiItemspubLisher.asObservable()
    }
    
    var indexObservable: Observable<Int> {
        return indexItemBehavior.asObserver()
    }
    private let moveiItemspubLisher = BehaviorSubject<Movie>(value: Movie())
    private let indexItemBehavior = BehaviorSubject<Int>(value: 0)
    var movieIDBehaviorRelay = BehaviorRelay<Int>(value: 0)
    private var bag = DisposeBag()
    
    init() {
        movieItem.subscribe(onNext: {[weak self] movie in
            guard let `self` = self else {return}
            self.moveiItemspubLisher.onNext(movie)
            self.movieIDBehaviorRelay.accept(movie.id ?? 0)
        }).disposed(by: bag)
        
        indexPublisher.subscribe(onNext: {[weak self] index in
            guard let `self` = self else {return}
            self.indexItemBehavior.onNext(index)
        }).disposed(by: bag)
        

        
    }
    
    func getImage(with url: String) -> UIImage {
        var img: UIImage?
        ImageManager.share.fetchImage(with: url, completion: {[weak self] image in
            guard let `self` = self else {return}
            img = image
        })
        return img ?? UIImage()
    }
    
    func addFavoriteMovie(with idMovie: Int) -> Driver<RequestFavoriteMovie> {
       return APIService.createFavoriteMovie(with: RequestFavoriteMovie.self, movieID: idMovie, isFavorite: true).asDriver(onErrorJustReturn: RequestFavoriteMovie())
    }
    
    func unFavoriteMovie(with idMovie: Int) -> Driver<RequestFavoriteMovie> {
        return APIService.createFavoriteMovie(with: RequestFavoriteMovie.self, movieID: idMovie, isFavorite: false).asDriver(onErrorJustReturn: RequestFavoriteMovie())
    }
    
    func fecthVideos(with idMovie: Int) -> Driver<VideosResponse> {
        return APIService.fetchVideo(with: VideosResponse.self, movieId: idMovie).asDriver(onErrorJustReturn: VideosResponse())
    }
}
