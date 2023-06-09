//
//  TabBarController.swift
//  MovieApp
//
//  Created by BeeTech on 09/06/2023.
//

import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let homevc = HomeViewController()
        
        self.setViewControllers([homevc], animated: false)
        self.tabBar.backgroundColor = .red
        self.tabBar.tintColor = .blue
    }
}
