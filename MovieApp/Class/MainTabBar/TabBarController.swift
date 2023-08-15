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
        let homeNavTab = UINavigationController(rootViewController: HomeViewController())
        homeNavTab.tabBarItem = homeTabItem
        return homeNavTab
    }()

    lazy var editTab: UIViewController = {
        let randomTabItem = UITabBarItem(title: "Reels", image: Asset.icPlay.image, selectedImage: nil)
        let navController = UINavigationController(rootViewController: ReelsViewController())
        navController.tabBarItem = randomTabItem
        navController.navigationController?.isNavigationBarHidden = false
        return navController
    }()

    lazy var notificationTab: UIViewController = {
        let commentTabItem = UITabBarItem(title: "Favorite", image: Asset.icHeart.image, selectedImage: nil)
        let navController = UINavigationController(rootViewController: FavoriteMovieViewController())
        navController.tabBarItem = commentTabItem
        return navController
    }()

    lazy var moreTab: UIViewController = {
        let commentTabItem = UITabBarItem(title: "Profile", image: Asset.icProfile.image, selectedImage: nil)
        let naviController = UINavigationController(rootViewController: ProfileViewController())
        naviController.tabBarItem = commentTabItem
        return naviController
    }()
    
    lazy var chatTab: UIViewController = {
        let chatTabItem = UITabBarItem(title: "Chat", image: UIImage(systemName: "message.fill"), selectedImage: nil)
        let naviController = UINavigationController(rootViewController: ChatViewController())
        naviController.tabBarItem = chatTabItem
        return naviController
    }()
    
    lazy var bookTap: UIViewController = {
        let bookItem = UITabBarItem(title: "Search", image: Asset.icSearch.image, selectedImage: nil)
        let naviController = UINavigationController(rootViewController: SearchViewController())
        naviController.tabBarItem = bookItem
        return naviController
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
        setupUI()
    }
    
    // MARK: - UI
    private func setupUI() {
        tabBar.backgroundColor = .white
    }
    
    private func setupViewController() {
        self.setViewControllers([homeTab, bookTap, editTab, moreTab], animated: true)
    }
}

