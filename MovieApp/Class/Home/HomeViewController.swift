//
//  HomeViewController.swift
//  MovieApp
//
//  Created by BeeTech on 09/06/2023.
//

import UIKit
import Combine

class HomeViewController: BaseViewController {
    @IBOutlet weak var contenView: UIView!
    @IBOutlet weak var tabBarView: UIView!
    @IBOutlet var tabBarButton: [UIButton]!
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var notificationView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    private let viewModel: HomeViewModel = HomeViewModel()
    private var dataSource: HomeDataSource = HomeDataSource()
    private var subcriptions = Set<AnyCancellable>()
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.fetchUser()
        setupTabelView()
        setupViewModel()
    }
    
    override func setupViewModel() {
        viewModel.userPublisher.sink { [weak self] userData in
            guard let `self` = self else { return }
            self.nameLabel.text = userData.userName ?? ""
        }
        .store(in: &subcriptions)
    }
    
    override func viewWillLayoutSubviews() {
        tabBarView.setCornerRadiusAndBorder(topLeftRadius: 8, topRightRadius: 8, bottomRightRadius: 0, bottomLeftRadius: 0)
        tabBarView.cornerRadiusTopLeft()
        tabBarView.layer.cornerRadius = 18
        tabBarView.clipsToBounds = true
        tabBarView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
    }
    
    override func setupUI() {
        avatarImage.cornerRadius(avatarImage.frame.size.height / 2)
        notificationView.cornerRadius(10)
    }
    
    private func setupTabelView() {
        tableView.delegate = dataSource
        tableView.dataSource = dataSource
        tableView.register(UINib(nibName: "CategoryTableViewCell", bundle: nil), forCellReuseIdentifier: "CategoryTableViewCell")
        tableView.register(UINib(nibName: "DetailTableViewCell", bundle: nil), forCellReuseIdentifier: "DetailTableViewCell")
        tableView.register(UINib(nibName: "FavoritesTableViewCell", bundle: nil), forCellReuseIdentifier: "FavoritesTableViewCell")
        tableView.register(UINib(nibName: "RecentTableViewCell", bundle: nil), forCellReuseIdentifier: "RecentTableViewCell")
    }
    override func setupTap() {
        tabBarButton.forEach { button in
            button.addTarget(self, action: #selector(didTapButton(_:)), for: .touchUpInside)
        }
    }
    
//MARK: Navigation
    
    @objc func didTapButton(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            let vc = HomeViewController()
            vc.view.backgroundColor  = .green
            contenView.addSubview(vc.view)
            push(vc)
            vc.didMove(toParent: self)
        case 1:
            let vc = ReelsViewController()
            vc.view.backgroundColor  = .red
            contenView.addSubview(vc.view)
            push(vc)
            vc.didMove(toParent: self)
        case 2:
            let vc = SearchViewController()
            vc.view.backgroundColor  = .yellow
            contenView.addSubview(vc.view)
            push(vc)
            vc.didMove(toParent: self)
        case 3:
            let vc = FavoriteMovieViewController()
            vc.view.backgroundColor  = .blue
            contenView.addSubview(vc.view)
            push(vc)
            vc.didMove(toParent: self)
        case 4:
            let vc = ProfileViewController()
            vc.view.backgroundColor  = .gray
            contenView.addSubview(vc.view)
            push(vc)
            vc.didMove(toParent: self)
        default:
            break
        }
    }
}
