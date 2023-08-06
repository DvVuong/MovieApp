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
    @IBOutlet weak var heightContrainstableView: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    
    private var isHidingTabBar: Bool = false
    private let viewModel: HomeViewModel = HomeViewModel()
    private var dataSource: HomeDataSource = HomeDataSource()
    private var subcriptions = Set<AnyCancellable>()
    private var bag = DisposeBag()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
        
        viewModel.fetchOnTheAirMovie()
            .drive(onNext: {[weak self] item in
                guard let `self` = self else {return}
                self.dataSource.setupTableViewForOnTheAirMovie(width: self.tableView, list: item.results)
            })
            .disposed(by: bag)
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
                self.dataSource.setupTableViewForListMovie(width: self.tableView, list: movies.results)
            })
            .disposed(by: bag)
        
        viewModel.fetchTopRateMovie()
            .drive(onNext: {[weak self] item in
                guard let `self` = self else {return}
                self.dataSource.setupTableViewForTopRateMovie(width: self.tableView, list: item.results)
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
            self.pushToDetailView(with: vc)
        }
        
        dataSource.actionMoveToDetaiViewRecent = {[weak self] item in
            guard let `self` = self else {return}
            let vc = DetailMovieViewController(item: item)
            self.pushToDetailView(with: vc)
        }
        
        dataSource.actionMoveToDetaiViewWithFavorites = {[weak self] item in
            guard let `self` = self else {return}
            let vc = DetailMovieViewController(item: item)
            self.pushToDetailView(with: vc)
        }
    }
    
    private func pushToDetailView(with vc: UIViewController) {
        vc.hidesBottomBarWhenPushed = true
        self.push(vc)
    }
    
    private func setupTabelView() {
        dataSource.delegate = self
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
    func didChooseAnime() {
        print("vuongdv")
    }
    
    func didChooseTVShow() {
        viewModel.fecthTVList()
            .drive(onNext: {[weak self] item in
                guard let `self` = self else {return}
                self.dataSource.setupTableViewForTvList(width: self.tableView, list: item.results)
            })
            .disposed(by: bag)
    }
    
    func didChooseMyList() {
        print("vuongdv")
    }
    
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
