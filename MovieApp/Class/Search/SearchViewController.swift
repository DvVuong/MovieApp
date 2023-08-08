//
//  SearchViewController.swift
//  MovieApp
//
//  Created by mr.root on 6/11/23.
//

import UIKit

class SearchViewController: BaseViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.topItem?.title =  "Search"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.backgroundColor = .red
        
    }
}
