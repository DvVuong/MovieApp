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
    
    var movieObservable: Observable<Movie> {
        return moveiItemspubLisher.asObservable()
    }
    private let moveiItemspubLisher = BehaviorSubject<Movie>(value: Movie())
    private var bag = DisposeBag()
    
    init() {
        movieItem.subscribe(onNext: {[weak self] movie in
            guard let `self` = self else {return}
            self.moveiItemspubLisher.onNext(movie)
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
}
