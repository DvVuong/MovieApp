//
//  BaseViewController.swift
//  MovieApp
//
//  Created by mr.root on 5/28/23.
//

import UIKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTap()
    }
    
    func setupUI() {}
    func setupTap() {}
    func setupViewModel() {}
    func bindData() {}
    func onBind() {}
}
