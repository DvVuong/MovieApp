//
//  Progressloading.swift
//  MovieApp
//
//  Created by mr.root on 8/14/23.
//

import SVProgressHUD
import RxSwift
import RxCocoa
import MBProgressHUD
import UIKit

struct Progressloading {
    //Step 1: Create view, default View
    weak var view: UIView?
    
    private let _defaultView: UIView = UIView()
    
    init(view: UIView?) {
        self.view = view
    }
    
    /// Step2: getView
    var getView: UIView {
        return view ?? _defaultView
    }
}

extension Progressloading {
    ///Step3: show or hide when subcrise
    public var rx_progress_animating: AnyObserver<Bool> {
        return AnyObserver { event in
            MainScheduler.ensureExecutingOnScheduler()
            switch (event) {
            case .next(let value):
                if value {
                    MBProgressHUD.showAdded(to: getView, animated: true)
                } else {
                    MBProgressHUD.hide(for: getView, animated: true)
                }
                break
            case .error(_):
                MBProgressHUD.hide(for: getView, animated: true)
                break
            case .completed:
                MBProgressHUD.hide(for: getView, animated: true)
                break
            }
        }
    }
}

