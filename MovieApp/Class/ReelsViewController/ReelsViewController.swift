//
//  ReelsViewController.swift
//  MovieApp
//
//  Created by mr.root on 6/11/23.
//

import UIKit
import RxSwift
import RxCocoa

class ReelsViewController: BaseViewController {

    private lazy var tableView: UITableView = {
       let tableView = UITableView()
        return tableView
    }()
    
    private let viewModel: ReelsViewModel = ReelsViewModel()
    private var bag = DisposeBag()
    private var dataSource: ReeslsDataSource = ReeslsDataSource()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        view.addSubview(tableView)
        tableView.frame = view.bounds
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewModel()
        setupConfigNavi()
    }
    
    override func setupUI() {
        tableView.register(UpComingTableViewCell.self, forCellReuseIdentifier: UpComingTableViewCell.indentifier)
        tableView.delegate = dataSource
        tableView.dataSource = dataSource
        dataSource.delegate = self
    }
    
    private func setupConfigNavi() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.topItem?.title = "UpComning"
    }
    
    override func setupViewModel() {
        viewModel.fetchUpComingMovie()
            .drive(onNext: {[weak self] items in
                guard let `self` = self else {return}
                self.dataSource.setTableView(width: self.tableView, lists: items.results)
                self.tableView.reloadData()
            })
            .disposed(by: bag)
    }
}

extension ReelsViewController: ReeslsDataSourceDelegate {
    func didTapItem(with item: Movie) {
        let vc = DetailMovieViewController(item: item, index: 0)
        self.push(vc)
    }
    
    
}

