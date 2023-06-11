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
       let homeVc = HomeViewController()

        homeVc.tabBarItem = UITabBarItem(title: nil, image: Asset.icHomeNotSelected.image, selectedImage: Asset.icHomeSelected.image)
        homeVc.tabBarItem.tag = 0
        
//        viewController2?.tabBarItem = UITabBarItem(title: "", image: <#T##UIImage?#>, selectedImage: <#T##UIImage?#>)
//        viewController2?.tabBarItem.tag = 0
//
//        viewController3?.tabBarItem = UITabBarItem(title: "", image: <#T##UIImage?#>, selectedImage: <#T##UIImage?#>)
//        viewController3?.tabBarItem.tag = 0
//
//        viewController4?.tabBarItem = UITabBarItem(title: "", image: <#T##UIImage?#>, selectedImage: <#T##UIImage?#>)
//        viewController4?.tabBarItem.tag = 0
//
//        viewController5?.tabBarItem = UITabBarItem(title: "", image: <#T##UIImage?#>, selectedImage: <#T##UIImage?#>)
//        viewController5?.tabBarItem.tag = 0
        
        self.setViewControllers([homeVc], animated: true)
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

