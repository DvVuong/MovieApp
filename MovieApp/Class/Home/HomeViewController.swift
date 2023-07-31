//
//  HomeViewController.swift
//  MovieApp
//
//  Created by BeeTech on 09/06/2023.
//

import UIKit
import Combine
import RxSwift
import RxCocoa

class HomeViewController: BaseViewController {
//    @IBOutlet weak var headerView: UIView!
//    @IBOutlet weak var heigthConstrainHeaderView: NSLayoutConstraint!
    @IBOutlet weak var heightContrainstableView: NSLayoutConstraint!
//    @IBOutlet weak var avatarImage: UIImageView!
//    @IBOutlet weak var nameLabel: UILabel!
//    @IBOutlet weak var notificationView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    
    private var isHidingTabBar: Bool = false
    private let viewModel: HomeViewModel = HomeViewModel()
    private var dataSource: HomeDataSource = HomeDataSource()
    private var subcriptions = Set<AnyCancellable>()
    private var bag = DisposeBag()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.fetchUser()
        setupTabelView()
        setupViewModel()
        setupDataSource()
    }
    
    override func viewWillLayoutSubviews() {
            super.viewWillLayoutSubviews()
            let safeAreaInsets: UIEdgeInsets = UIEdgeInsets(top: 0,
                                                            left: 0,
                                                            bottom: self.tabBarController?.view.safeAreaInsets.bottom ?? 0,
                                                            right: 0)
            tableView.contentInset = safeAreaInsets
            tableView.scrollIndicatorInsets = safeAreaInsets
        }
        
        func hideTabBarIfNeeded() {
            guard !self.isHidingTabBar else { return }
            self.isHidingTabBar = true
            self.tabBarController?.setTabBar(hidden: true, animated: true)
        }
        
        func showTabBarIfNeeded() {
            guard self.isHidingTabBar else { return }
            self.isHidingTabBar = false
            self.tabBarController?.setTabBar(hidden: false, animated: true)
        }
    
    override func setupViewModel() {
        viewModel.userPublisher.sink { [weak self] userData in
            guard let `self` = self else { return }
            self.configureNavi(with: nil, nameUser: userData.userName)

        }
        .store(in: &subcriptions)
        
        viewModel.fetchListMovie()
            .drive(onNext: {[weak self] movies in
                guard let `self` = self else {return}
                self.dataSource.setupTableView(width: self.tableView, list: movies.results)
                self.tableView.reloadData()
            })
            .disposed(by: bag)
        
        viewModel.fetchTopRateMovie()
            .drive(onNext: {[weak self] item in
                guard let `self` = self else {return}
                self.dataSource.setupTableView(width: self.tableView, listTopRate: item.results)
                self.dataSource.indexPath = {[weak self] indexPath in
                    guard let `self` = self else {return}
                    self.tableView.rectForRow(at: indexPath)
                }
                
            })
            .disposed(by: bag)
        
        viewModel.fetchOnTheAirMovie()
            .drive(onNext: {[weak self] item in
                guard let `self` = self else {return}
                self.dataSource.setupTableView(width: self.tableView, listOnTheAir: item.results)
                self.dataSource.indexPath = {[weak self] indexPath in
                guard let `self` = self else {return}
                self.tableView.rectForRow(at: indexPath)
            }
                
            })
            .disposed(by: bag)
    }
    
    private func configureNavi(with image: String?, nameUser: String?) {
        guard let name = nameUser else {return}
        let navi = navigationController!
        
        let customView = CustomNavigationBarView(frame: CGRect(x: 0, y: 0, width: navi.navigationBar.frame.width, height: navi.navigationBar.frame.height))
        customView.backgroundColor = .clear
        customView.textLabel.text = name
        customView.textLabel.textColor = .black
        customView.avatarImage.image = Asset.caitlynArcaneWickellia.image
        customView.heightAvatarImage = navi.navigationBar.frame.height - 5
        customView.setupCustomUI()
        
        // Thêm view vào navigationBar
        if let navigationBar = self.navigationController?.navigationBar {
            navigationBar.addSubview(customView)
        }
    }
    override func setupDataSource() {
        dataSource.delegate = self
        dataSource.actionMoveToDetaiView = { [weak self] item in
            guard let `self` = self else { return }
            let vc = DetailMovieViewController(item: item)
            vc.hidesBottomBarWhenPushed = true
            self.push(vc)
        }
    }
    
    private func setupTabelView() {
        tableView.delegate = dataSource
        tableView.dataSource = dataSource
        tableView.register(UINib(nibName: "CategoryTableViewCell", bundle: nil), forCellReuseIdentifier: "CategoryTableViewCell")
        tableView.register(UINib(nibName: "DetailTableViewCell", bundle: nil), forCellReuseIdentifier: "DetailTableViewCell")
        tableView.register(UINib(nibName: "FavoritesTableViewCell", bundle: nil), forCellReuseIdentifier: "FavoritesTableViewCell")
        tableView.register(UINib(nibName: "RecentTableViewCell", bundle: nil), forCellReuseIdentifier: "RecentTableViewCell")
        
        tableView.register(CustomHeaderView.self, forHeaderFooterViewReuseIdentifier: "CustomHeader")
    }
   
//MARK: Navigation
    
    @objc func didTapButton(_ sender: UIButton) {
       
    }
}
extension HomeViewController: HomeDataSourceDelegate {
    func showTabBar() {
        showTabBarIfNeeded()
        print("vuongdv1 ShowTabar")
    }
    
    func willHideTabbar() {
        hideTabBarIfNeeded()
        print("vuongdv HideTabbar")
    }
    
    func willShowTabbar() {
        showTabBarIfNeeded()
        print("vuongdv2 ShowTabar")
    }
    
    
}


