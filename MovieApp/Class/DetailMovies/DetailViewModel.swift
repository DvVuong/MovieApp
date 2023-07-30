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
    let movieItemBehaviorRelay = BehaviorRelay<Movie>(value: Movie(i: nil, name: nil, q: nil, cast: nil, year: nil))
    let imgUrlBehaviorRelay = BehaviorRelay<String>(value: "")
    private var bag = DisposeBag()
    
    init() {
        movieItem.subscribe(onNext: {[weak self] movie in
            guard let `self` = self else {return}
            self.imgUrlBehaviorRelay.accept(movie.i?.imageUrl ?? "")
            self.movieItemBehaviorRelay.accept(movie)
        }).disposed(by: bag)
        
        
        
    }
    
    func getImage() -> UIImage {
        var img: UIImage?
        
        ImageManager.share.fetchImage(with: imgUrlBehaviorRelay.value, completion: {[weak self] image in
            guard let `self` = self else {return}
            img = image
        })
        return img ?? UIImage()
    }
}
