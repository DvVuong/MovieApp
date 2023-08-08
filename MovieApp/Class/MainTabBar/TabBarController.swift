//
//  TabBarController.swift
//  MovieApp
//
//  Created by BeeTech on 09/06/2023.
//

import UIKit
import CardTabBar

class TabBarController: UITabBarController {
    
    lazy var homeTab: UIViewController = {
        let homeTabItem = UITabBarItem(title: "Home", image: Asset.icHome.image, selectedImage: nil)
        let homeNavTab = NavigationController(rootViewController: HomeViewController())
        homeNavTab.tabBarItem = homeTabItem
        return homeNavTab
    }()

    lazy var editTab: UIViewController = {
        let randomTabItem = UITabBarItem(title: "Reels", image: Asset.icPlay.image, selectedImage: nil)
        let navController = NavigationController(rootViewController: ReelsViewController())
        navController.tabBarItem = randomTabItem
        navController.navigationController?.isNavigationBarHidden = false
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
        let naviController = NavigationController(rootViewController: ProfileViewController())
        naviController.tabBarItem = commentTabItem
        return naviController
    }()
    
    lazy var chatTab: UIViewController = {
        let chatTabItem = UITabBarItem(title: "Chat", image: UIImage(systemName: "message.fill"), selectedImage: nil)
        let naviController = NavigationController(rootViewController: ChatViewController())
        naviController.tabBarItem = chatTabItem
        naviController.navigationController?.isNavigationBarHidden = true
        return naviController
    }()
    
    lazy var bookTap: UIViewController = {
        let bookItem = UITabBarItem(title: "Search", image: Asset.icSearch.image, selectedImage: nil)
        let naviController = NavigationController(rootViewController: SearchViewController())
        naviController.tabBarItem = bookItem
        naviController.navigationController?.isNavigationBarHidden = true
        return naviController
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       self.navigationController?.isNavigationBarHidden = false
    }

    // MARK: - UI
    private func setupUI() {
        //tabBar.tintColor = .TabBar.title
        tabBar.backgroundColor = .darkGray.withAlphaComponent(0.1)
       // tabBar.barTintColor = .Navigation.background
        //tabBar.indicatorColor = .TabBar.itemBackground
    }
    
    private func setupViewController() {
        viewControllers = [homeTab, bookTap, editTab, chatTab, moreTab]
    }

}

