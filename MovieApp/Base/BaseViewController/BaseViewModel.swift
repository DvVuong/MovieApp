//
//  BaseViewModel.swift
//  MovieApp
//
//  Created by mr.root on 8/14/23.
//

import RxSwift
import RxCocoa

class BaseViewModel: NSObject {
    static var shared: BaseViewModel = BaseViewModel()
    
    internal let bag = DisposeBag()
    /// Tạo view cho Progress
    private weak var progressView: UIView? = nil
    
    /// Bind view container containt progress
    public func bindViewProgress(view: UIView) {
        progressView = view
    }
    
    /// UI Progress
    private var makeProgress: Progressloading {
        let progress = Progressloading(view: progressView)
        return progress
    }
    
    internal lazy var makeActivityIndicator: ActivityIndicator =  {
        let indicator = ActivityIndicator()
        indicator.asObservable()
            .bind(to: makeProgress.rx_progress_animating)
            .disposed(by: bag)
        return indicator
    }()
}
    
