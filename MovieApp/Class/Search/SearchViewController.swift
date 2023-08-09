//
//  SearchViewController.swift
//  MovieApp
//
//  Created by mr.root on 6/11/23.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class SearchViewController: BaseViewController {
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet var widthContrainsViewSearch: NSLayoutConstraint!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var movieButton: UIButton!
    @IBOutlet weak var tvShowButton: UIButton!
    @IBOutlet weak var typeStackView: UIStackView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var typeLabel: CustomLabel!
    
    private var viewModel: SearchViewModel = SearchViewModel()
    private var dataSource: SearchDataSource = SearchDataSource()
    
    private var bag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        conficgerNavi()
        setupUI()
        viewModel.test(with: searchTextField)
        setupViewModel()
    }
    
   override func setupUI() {
       typeStackView.isHidden = true
       searchTextField.delegate = self
       searchTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
       //SetuptableView
       tableView.delegate = dataSource
       tableView.dataSource = dataSource
       tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 5, right: 0)
       tableView.register(UINib(nibName: "MovieTableViewCell", bundle: nil), forCellReuseIdentifier: "MovieTableViewCell")
       dataSource.delegate = self
    }
    
    override func setupTap() {
        
        cancelButton.rx.tap
            .withUnretained(self)
            .subscribe(onNext: {owner, _ in
                UIView.animate(withDuration: 0.5) {
                    owner.navigationController?.isNavigationBarHidden = false
                    owner.widthContrainsViewSearch.constant = -10
                    owner.view.endEditing(true)
                    owner.typeStackView.isHidden = false
                    owner.searchTextField.text = ""
                }
            })
            .disposed(by: bag)
        
        movieButton.rx.tap
            .withUnretained(self)
            .subscribe(onNext: {owner, _ in
                owner.typeLabel.text = "Movie: "
                owner.searchTextField.becomeFirstResponder()
                owner.viewModel.typeBehaviorRelay.accept("movie")
            })
            .disposed(by: bag)
        
        tvShowButton.rx.tap
            .withUnretained(self)
            .subscribe(onNext: {owner, _ in
                owner.typeLabel.text = "TVShow: "
                owner.viewModel.typeBehaviorRelay.accept("tv")
                owner.searchTextField.becomeFirstResponder()
            })
            .disposed(by: bag)
    }
    
    override func setupViewModel() {
        viewModel.movieObservable
            .withUnretained(self)
            .subscribe(onNext: {onwer, items in
                onwer.dataSource.setTableView(with: self.tableView, lists: items.results)
                DispatchQueue.main.async {
                    onwer.tableView.reloadData()
                }
            })
            .disposed(by: bag)
    }
    
    private func conficgerNavi() {
        self.navigationController?.navigationBar.topItem?.title = "Search"
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        UIView.animate(withDuration: 0.5) { [weak self] in
            guard let `self` = self else {return}
            self.navigationController?.isNavigationBarHidden = true
            self.widthContrainsViewSearch.constant = -90
            self.typeStackView.isHidden = false
        }
        return true
    }
    
    //MARK: -Action
    
    @objc private func textFieldDidChange(_ sender: UITextField) {
        if sender === searchTextField {
        }
    }
    
    @objc private func didTapCancelInputText(_ sender: UIButton) {
       
    }
}

extension SearchViewController: SearchDataSourceDelegate {
    func didChooseItem(with item: Movie) {
        let vc = DetailMovieViewController(item: item, index: 0)
        vc.hidesBottomBarWhenPushed = true
        self.push(vc)
    }
}
