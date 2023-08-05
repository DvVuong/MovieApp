//
//  DetailMovieViewController.swift
//  MovieApp
//
//  Created by BeeTech on 15/06/2023.
//

import UIKit
import RxSwift
import RxCocoa

class DetailMovieViewController: BaseViewController {
    @IBOutlet weak var tableView: UITableView!
    
    private var dataSource: TableViewDataSource = TableViewDataSource()
    private var viewModel: DetailViewModel = DetailViewModel()
    private var bag = DisposeBag()
    private var headerTableView = HeaderCell()
    convenience init(item: Movie) {
        self.init()
        viewModel.movieItem.onNext(item)
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
        viewModel.movieObservable
            .withUnretained(self)
            .do(onNext: { onwner , movie in
                onwner.headerTableView.bindData(with: movie)
            })
            .subscribe(onNext: {onwner, movie in
                onwner.dataSource.setUpTableView(with: onwner.tableView, lists: movie)
        })
        .disposed(by: bag)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        headerTableView.frame = CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 450)
    }
    
    override func setupTap() {
        headerTableView.backButton.rx.tap
            .withUnretained(self)
            .subscribe(onNext: {owner, _ in
                owner.pop()
            })
            .disposed(by: bag)
    }
    
    override func setupUI() {
        tableView.delegate = dataSource
        tableView.dataSource = dataSource
        tableView.tableHeaderView = headerTableView
        tableView.separatorStyle = .none
        tableView.register(DetailMovieTableViewCell.self, forCellReuseIdentifier: DetailMovieTableViewCell.indentifier)
        tableView.register(DesciptionTableCell.self, forCellReuseIdentifier: DesciptionTableCell.indentifier)
    }
    
    //MARK: Action
    
    @objc private func didTapButton(_ sender: UIButton) {
        pop()
    }
}
