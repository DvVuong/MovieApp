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
        setupDataSource()
    }
    
    override func setupViewModel() {
        viewModel.userPublisher.sink { [weak self] userData in
            guard let `self` = self else { return }
            self.nameLabel.text = userData.userName ?? ""
        }
        .store(in: &subcriptions)
    }
    override func setupDataSource() {
        dataSource.actionMoveToDetaiView = { [weak self] in
            guard let `self` = self else { return }
            let vc = DetailMovieViewController()
            vc.hidesBottomBarWhenPushed = true
            self.push(vc)
        }
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

    }
    
//MARK: Navigation
    
    @objc func didTapButton(_ sender: UIButton) {
       
    }
}
