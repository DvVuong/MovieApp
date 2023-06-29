//
//  ChatViewController.swift
//  MovieApp
//
//  Created by mr.root on 6/21/23.
//

import UIKit
import Combine

class ChatViewController: BaseViewController {
    @IBOutlet weak var headerView: CustomNavigationHeader!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var userTableView: UITableView!
    @IBOutlet weak var searchUserTextField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var heightSearchView: NSLayoutConstraint!
    @IBOutlet weak var searchView: UIView!
    
    private let dataSource: ChatViewDataSource = ChatViewDataSource()
    private let viewModel: ChatViewModel = ChatViewModel()
    private var subscriptions = Set<AnyCancellable>()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTableView()
        viewModel.deMozip()
        setupTextField()
    }
    
    override func setupUI() {
        headerView.defaultItem()
        headerView.title = "Chat"
    }
    
    override func setupTap() {
        searchButton.addTarget(self, action: #selector(didTapButton(_:)), for: .touchUpInside)
    }
    
    override func setupViewModel() {
        
    }
    private func setupTextField() {
        searchUserTextField.delegate = self
    }
    
    private func setupTableView() {
        userTableView.isHidden = true
        tableView.delegate = dataSource
        tableView.dataSource = dataSource
        Publishers.Zip(viewModel.userPublisher, viewModel.messagePublisher)
            .sink { [weak self] data in
                guard let `self` = self else { return }
                self.dataSource.setTableView(self.tableView, list: data.1, userList: data.0)
            }.store(in: &subscriptions)
        tableView.register(UINib(nibName: "UserActiveTableViewCell", bundle: nil), forCellReuseIdentifier: "UserActiveTableViewCell")
        tableView.register(UINib(nibName: "MessageTableViewCell", bundle: nil), forCellReuseIdentifier: "MessageTableViewCell")
    }
    
     func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
         if textField === searchUserTextField {
             UIView.transition(with: self.searchView, duration: 0.5, options: .allowAnimatedContent
                               , animations: {
                 self.heightSearchView.constant = 5
                 self.tableView.isHidden = true
                 self.userTableView.isHidden = true
             }, completion: nil)
             
         }
        return true
    }
    
    @objc private func didTapButton(_ sender: UIButton) {
        if sender === searchButton {
            UIView.transition(with: self.searchView, duration: 0.5, options: .transitionCrossDissolve
                              , animations: {
                self.userTableView.isHidden = true
                self.tableView.isHidden = false
                self.heightSearchView.constant = 50
            }, completion: nil)
            
        }
    }
}

