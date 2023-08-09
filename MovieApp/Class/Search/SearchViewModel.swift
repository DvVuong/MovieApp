//
//  SearchViewModel.swift
//  MovieApp
//
//  Created by mr.root on 8/9/23.
//

import Foundation
import RxSwift
import RxRelay
import RxCocoa
import UIKit

class SearchViewModel {
    var typeBehaviorRelay = BehaviorRelay<String>(value: "")
    var movieObservable: Observable<MovieRespone> {
        return movieBeahviorRelay.asObservable()
    }
    
    private var movieBeahviorRelay = BehaviorRelay<MovieRespone>(value: MovieRespone())
    private var bag = DisposeBag()
    init() {
    }
    
    func fetchMovieWithTextInput(with text: String) -> Driver<MovieRespone>  {
      return  APIService.searchMovieTV(with: MovieRespone.self, type: typeBehaviorRelay.value, text: text, page: 1)
            .asDriver(onErrorJustReturn: MovieRespone())
    }
    
    func test(with textFiled: UITextField) {
        textFiled.rx.text.orEmpty
            .throttle(.milliseconds(300), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .flatMapLatest({ query  -> Observable<MovieRespone> in
                if query.isEmpty {
                    return .just(MovieRespone())
                }
                return APIService.searchMovieTV(with: MovieRespone.self,
                                                type: self.typeBehaviorRelay.value,
                                                text: query,
                                                page: 1)
            })
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] movieResponse in
                guard let `self` = self else {return}
                self.movieBeahviorRelay.accept(movieResponse)
            })
            .disposed(by: bag)            
    }
}
