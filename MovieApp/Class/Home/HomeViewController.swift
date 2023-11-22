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
    private var indexItemMovie: Int? = 0
    private var movies: [Movie]? = []
    private var refreshControll = UIRefreshControl()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
        viewModel.fetchOnTheAirMovie()
            .drive(onNext: {[weak self] item in
                var movies: [Movie] = []
                guard let `self` = self, let data = item.results else {return}
                for i in data {
                    let movie = Movie(backdropPath: i.backdropPath,id: i.id,title: i.title,originalLanguage: i.originalLanguage,originalTitle: i.originalTitle,overview: i.overview,posterPath: i.posterPath,mediaType: i.mediaType,releaseDate: i.releaseDate,voteAverage: i.voteAverage,isFavorites: true)
                    movies.append(movie)
                }
                self.dataSource.setupTableViewForOnTheAirMovie(width: self.tableView, list: movies)
            })
            .disposed(by: bag)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.fetchUser()
        setupTabelView()
        setupViewModel()
        setupDataSource()
        refreshTableView()
        viewModel.getData()
    }
    override func setupViewModel() {
        super.bindViewModel(viewModel)
        viewModel.userPublisher.sink { [weak self] user in
            guard let `self` = self else { return }
            self.configureNavi(with: nil, nameUser: user.userName ?? "")
        }
        .store(in: &subcriptions)
        
        viewModel.arrItemsMovie.subscribe(onNext: { item in
            DispatchQueue.main.async {
                self.dataSource.setupTableViewForTopRateMovie(width: self.tableView, list: item)
            }
        }).disposed(by: bag)
        
        viewModel.fetchListMovie()
            .drive(onNext: {[weak self] movie in
                guard let `self` = self else {return}
                self.movies = movie.results
                self.dataSource.setupTableViewForListMovie(width: self.tableView, list: movie.results)
            })
            .disposed(by: bag)
    }

    private func configureNavi(with image: String?, nameUser: String?) {
        guard let name = nameUser else {return}
        guard let navi = navigationController else {return}
        let customView = CustomNavigationBarView(frame: CGRect(x: 0, y: 0, width: navi.navigationBar.frame.width, height: navi.navigationBar.frame.height))
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
        dataSource.actionMoveToDetaiView = { [weak self] item, index  in
            guard let `self` = self else { return }
            self.indexItemMovie = index
            let vc = DetailMovieViewController(item: item, index: index)
            vc.delegate = self
            self.pushToDetailView(with: vc)
        }
        
        dataSource.actionMoveToDetaiViewRecent = {[weak self] item in
            guard let `self` = self else {return}
            let vc = DetailMovieViewController(item: item, index: 0)
            self.pushToDetailView(with: vc)
        }
        
        dataSource.actionMoveToDetaiViewWithFavorites = {[weak self] item in
            guard let `self` = self else {return}
            let vc = DetailMovieViewController(item: item, index: 0)
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
        tableView.addSubview(refreshControll)
    }
    
    private func refreshTableView() {
        refreshControll.addTarget(self, action: #selector(refreshData(_:)), for: .valueChanged)
    }
   
//MARK: Navigation
    
    @objc func didTapButton(_ sender: UIButton) {
       
    }
    
    @objc func refreshData(_ sender: UIRefreshControl) {
        
        refreshControll.endRefreshing()
    }
}
extension HomeViewController: HomeDataSourceDelegate {
    func didChooseMovie() {
        viewModel.fetchListMovie()
            .drive(onNext: {[weak self] item in
                guard let `self` = self else {return}
                self.dataSource.setupTableViewForListMovie(width:        self.tableView, list: item.results)
            })
            .disposed(by: bag)
    }
    
    func didChooseAnime() {
        
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
        
    }
    
   func loadmoreNewsPost() {
       
       viewModel.getData()
    }
}

extension HomeViewController: DetailMovieViewControllerDelegate {
    func setFavoritesMovie(with isFavorites: Bool, index: Int) {
        print("vuongdv", isFavorites , "index", index)
    }
}
