//
//  DetailMovieViewController.swift
//  MovieApp
//
//  Created by BeeTech on 15/06/2023.
//

import UIKit
import RxSwift
import RxCocoa

protocol DetailMovieViewControllerDelegate: AnyObject {
    func setFavoritesMovie(with isFavorites: Bool, index: Int)
}

class DetailMovieViewController: BaseViewController {
    @IBOutlet weak var tableView: UITableView!
    
    private var dataSource: TableViewDataSource = TableViewDataSource()
    private var viewModel: DetailViewModel = DetailViewModel()
    private var bag = DisposeBag()
    private var headerTableView = HeaderCell()
    weak var delegate: DetailMovieViewControllerDelegate?
    
    convenience init(item: Movie, index: Int) {
        self.init()
        viewModel.movieItem.onNext(item)
        viewModel.indexPublisher.onNext(index)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupViewModel()
    }
    
    override func setupViewModel() {
        super.bindViewModel(viewModel)
        viewModel.movieObservable
            .withUnretained(self)
            .do(onNext: { onwner , movie in
                onwner.headerTableView.bindData(with: movie)})
                .subscribe(onNext: {onwner, movie in
                    onwner.dataSource.setUpTableView(with: onwner.tableView, lists: movie)
                })
                .disposed(by: bag)
                
        viewModel.indexObservable
            .withUnretained(self)
            .subscribe(onNext: {owner, index in
                owner.headerTableView.indexItem = index
            })
            .disposed(by: bag)
                
        viewModel.fecthVideos(with: viewModel.movieIDBehaviorRelay.value)
            .drive(onNext: {[weak self]  items in
                guard let `self` = self, let data = items.results else {return}
                var videos: [Video] = []
                for i in data {
                    if (i.type ?? "" ) == "Clip" || (i.type ?? "") == "Teaser" {
                        videos.append(i)
                    }
                 }
                self.dataSource.setupTableForTrailer(with: self.tableView, list: Array(videos.prefix(3)))
                self.tableView.reloadData()
            })
            .disposed(by: bag)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        headerTableView.frame = CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 450)
    }
    
    override func setupTap() {
        headerTableView.delegate = self
        headerTableView.backButton.rx.tap
            .withUnretained(self)
            .subscribe(onNext: {owner, _ in
                owner.pop()
            })
            .disposed(by: bag)
        
        headerTableView.actionChooseIDMovie = {[weak self] id in
            guard let `self` = self, let id = id else {return}
            self.viewModel.addFavoriteMovie(with: id)
                .drive(onNext: { item in
                  
                })
                .disposed(by: self.bag)
        }
        
        headerTableView.actionUnFavoriteMovie = {[weak self] id in
            guard let `self` = self, let id = id else {return}
            self.viewModel.unFavoriteMovie(with: id)
                .drive(onNext: {item in
                    
                })
                .disposed(by: self.bag)
        }
    }
    
    override func setupUI() {
        tableView.delegate = dataSource
        tableView.dataSource = dataSource
        tableView.tableHeaderView = headerTableView
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.register(DesciptionTableCell.self, forCellReuseIdentifier: DesciptionTableCell.indentifier)
        tableView.register(TrailerTableViewCell.self, forCellReuseIdentifier: TrailerTableViewCell.indentifer)
    }
    
    //MARK: Action
    
    @objc private func didTapButton(_ sender: UIButton) {
        pop()
    }
}

extension DetailMovieViewController: HeaderCellDelegate {
    func didTapFavourite(with isFavorites: Bool, index: Int) {
        delegate?.setFavoritesMovie(with: isFavorites, index: index)
    }
}
