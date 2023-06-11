//
//  HomeViewController.swift
//  MovieApp
//
//  Created by BeeTech on 09/06/2023.
//

import UIKit

class HomeViewController: BaseViewController {
    @IBOutlet weak var contenView: UIView!
    @IBOutlet weak var tabBarView: UIView!
    @IBOutlet var tabBarButton: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setupUI() {
        tabBarView.cornerRadius()
    }
    override func setupTap() {
        tabBarButton.forEach { button in
            button.addTarget(self, action: #selector(didTapButton(_:)), for: .touchUpInside)
        }
    }
    
    @objc func didTapButton(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            let vc = HomeViewController()
            vc.view.backgroundColor  = .green
            contenView.addSubview(vc.view)
            vc.didMove(toParent: self)
        case 1:
            let vc = ReelsViewController()
            vc.view.backgroundColor  = .red
            contenView.addSubview(vc.view)
            vc.didMove(toParent: self)
        case 2:
            let vc = SearchViewController()
            vc.view.backgroundColor  = .yellow
            contenView.addSubview(vc.view)
            vc.didMove(toParent: self)
        case 3:
            let vc = FavoriteMovieViewController()
            vc.view.backgroundColor  = .blue
            contenView.addSubview(vc.view)
            vc.didMove(toParent: self)
        case 4:
            let vc = ProfileViewController()
            vc.view.backgroundColor  = .gray
            contenView.addSubview(vc.view)
            vc.didMove(toParent: self)
        default:
            break
        }
    }
}
