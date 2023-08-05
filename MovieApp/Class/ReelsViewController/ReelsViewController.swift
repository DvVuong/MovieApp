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
    private var dataSource: ResslsDataSource = ResslsDataSource()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
        navigationController?.title = "Upcoming"
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewModel()
        view.addSubview(tableView)
        tableView.register(UpComingTableViewCell.self, forCellReuseIdentifier: UpComingTableViewCell.indentifier)
        tableView.delegate = dataSource
        tableView.dataSource = dataSource
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

