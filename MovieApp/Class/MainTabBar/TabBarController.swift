//
//  TabBarController.swift
//  MovieApp
//
//  Created by BeeTech on 09/06/2023.
//

import UIKit

class TabBarController: UITabBarController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let homeVc = HomeViewController()
        let searchVc = SearchViewController()
        let playVC = ReelsViewController()
        let favoriteVC = FavoriteMovieViewController()
        let profileVC = ProfileViewController()

        homeVc.tabBarItem = UITabBarItem(title: nil, image: Asset.icHomeNotSelected.image, selectedImage: Asset.icHomeSelected.image)
        homeVc.tabBarItem.tag = 0
        
        searchVc.tabBarItem = UITabBarItem(title: "", image: Asset.icSearchNotSelected.image, selectedImage: Asset.icSearchSelected.image)
        searchVc.tabBarItem.tag = 1

        playVC.tabBarItem = UITabBarItem(title: "", image: Asset.icPlaySelectedPng.image, selectedImage: Asset.icPlaySelectedPng.image)
        playVC.tabBarItem.tag = 2

        favoriteVC.tabBarItem = UITabBarItem(title: "", image: Asset.icHeartNotSelected.image, selectedImage: Asset.icHeartSelected.image)
        favoriteVC.tabBarItem.tag = 3

        profileVC.tabBarItem = UITabBarItem(title: "", image: Asset.icUserSelected.image, selectedImage: Asset.icUserSelected.image)
        profileVC.tabBarItem.tag = 4
        
        self.tabBarController?.tabBar.backgroundColor = UIColor.white.withAlphaComponent(0.4)
        self.setViewControllers([homeVc, playVC, searchVc , favoriteVC, profileVC], animated: true)
        self.selectedIndex = 0
        self.selectedViewController = homeVc
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        switch item.tag {
        case 0:
            break
        case 1:
            break
        case 3:
            break
        case 4:
            break
        case 5:
            break
        default:
            break
        }
    }
}

