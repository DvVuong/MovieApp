//
//  TabBarController.swift
//  MovieApp
//
//  Created by BeeTech on 09/06/2023.
//

import UIKit

class TabBarController: UITabBarController {
    var viewController1: ViewController?
    var viewController2: ViewController?
    var viewController3: ViewController?
    var viewController4: ViewController?
    var viewController5: ViewController?
    var subViewContoller: [UIViewController] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewController1 = ViewController()
        viewController2 = ViewController()
        viewController3 = ViewController()
        viewController4 = ViewController()
        viewController5 = ViewController()
        
        subViewContoller.append(viewController1 ?? ViewController())
        subViewContoller.append(viewController2 ?? ViewController())
        subViewContoller.append(viewController3 ?? ViewController())
        subViewContoller.append(viewController4 ?? ViewController())
        subViewContoller.append(viewController5 ?? ViewController())
        
        viewController1?.tabBarItem = UITabBarItem(title: <#T##String?#>, image: <#T##UIImage?#>, selectedImage: <#T##UIImage?#>)
        viewController1?.tabBarItem.tag = 0
        
        viewController2?.tabBarItem = UITabBarItem(title: "", image: <#T##UIImage?#>, selectedImage: <#T##UIImage?#>)
        viewController2?.tabBarItem.tag = 0
        
        viewController3?.tabBarItem = UITabBarItem(title: "", image: <#T##UIImage?#>, selectedImage: <#T##UIImage?#>)
        viewController3?.tabBarItem.tag = 0
        
        viewController4?.tabBarItem = UITabBarItem(title: "", image: <#T##UIImage?#>, selectedImage: <#T##UIImage?#>)
        viewController4?.tabBarItem.tag = 0
        
        viewController5?.tabBarItem = UITabBarItem(title: "", image: <#T##UIImage?#>, selectedImage: <#T##UIImage?#>)
        viewController5?.tabBarItem.tag = 0
        
        self.setViewControllers(subViewContoller, animated: true)
        self.selectedIndex = 0
        self.selectedViewController = viewController1
        
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

