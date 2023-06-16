//
//  TabBarController.swift
//  MovieApp
//
//  Created by BeeTech on 09/06/2023.
//

import UIKit
import CardTabBar

class TabBarController: CardTabBarController {
    
    lazy var homeTab: UIViewController = {
        let homeTabItem = UITabBarItem(title: "Home", image: Asset.icHome.image, selectedImage: nil)
        let homeNavTab = NavigationController(rootViewController: HomeViewController())
        homeNavTab.tabBarItem = homeTabItem
        return homeNavTab
    }()

    lazy var bookTab: UIViewController = {
        let searchTabItem = UITabBarItem(title: "Search", image: Asset.icSearch.image, selectedImage: nil)
        let navController = NavigationController(rootViewController: SearchViewController())
        navController.tabBarItem = searchTabItem
        return navController
    }()

    lazy var editTab: UIViewController = {
        let randomTabItem = UITabBarItem(title: "Reels", image: Asset.icPlay.image, selectedImage: nil)
        let navController = NavigationController(rootViewController: ReelsViewController())
        navController.tabBarItem = randomTabItem
        return navController
    }()

    lazy var notificationTab: UIViewController = {
        let commentTabItem = UITabBarItem(title: "Favorite", image: Asset.icHeart.image, selectedImage: nil)
        let navController = NavigationController(rootViewController: FavoriteMovieViewController())
        navController.tabBarItem = commentTabItem
        return navController
    }()

    lazy var moreTab: UIViewController = {
        let commentTabItem = UITabBarItem(title: "Profile", image: Asset.icProfile.image, selectedImage: nil)
        let navController = NavigationController(rootViewController: ProfileViewController())
        navController.tabBarItem = commentTabItem
        return navController
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }

    // MARK: - UI
    private func setupUI() {
        //tabBar.tintColor = .TabBar.title
        tabBar.backgroundColor = .darkGray.withAlphaComponent(0.1)
       // tabBar.barTintColor = .Navigation.background
        //tabBar.indicatorColor = .TabBar.itemBackground
    }
    
    private func setupViewController() {
        viewControllers = [homeTab, bookTab, editTab, notificationTab, moreTab]
    }

}

