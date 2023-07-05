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
    private let userDataSource: ListUserDataSource = ListUserDataSource()
    private let viewModel: ChatViewModel = ChatViewModel()
    private var subscriptions = Set<AnyCancellable>()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTableView()
        setupTextField()
        viewModel.fetchUser()
        viewModel.deMozip()
    }
    
    override func setupUI() {
        headerView.defaultItem()
        headerView.title = "Chat"
    }
    
    override func setupTap() {
        searchButton.addTarget(self, action: #selector(didTapButton(_:)), for: .touchUpInside)
    }
    
    private func setupTextField() {
        searchUserTextField.delegate = self
    }
    
    private func setupTableView() {
        userTableView.isHidden = true
        tableView.delegate = dataSource
        tableView.dataSource = dataSource
        tableView.tableFooterView = UIView()
        
        userTableView.delegate = userDataSource
        userTableView.dataSource = userDataSource
        userTableView.tableFooterView = UIView()
                
        userTableView.rowHeight = UITableView.automaticDimension
        userTableView.register(UINib(nibName: "ListUserTableViewCell", bundle: nil), forCellReuseIdentifier: "ListUserTableViewCell")
        tableView.register(UINib(nibName: "UserActiveTableViewCell", bundle: nil), forCellReuseIdentifier: "UserActiveTableViewCell")
        tableView.register(UINib(nibName: "MessageTableViewCell", bundle: nil), forCellReuseIdentifier: "MessageTableViewCell")
        
        viewModel.userPublisher.sink(receiveValue: {[weak self] data in
            guard let `self` = self else { return }
            self.userDataSource.setupTableView(self.userTableView, list: data)
            self.dataSource.setTableView(self.tableView, userList: data)
            self.tableView.reloadData()
            self.userTableView.reloadData()
        }).store(in: &subscriptions)
        
        viewModel.messagePublisher.sink(receiveValue: {[weak self] data in
            guard let `self` = self else {return}
            self.dataSource.setTableView(self.tableView, listMessage: data)
            self.tableView.reloadData()
        }).store(in: &subscriptions)
        
        dataSource.didGetReciverUser = {[weak self] user in
            guard let `self` = self else {return}
            let vc = DetailChatViewController(reciverUser: user)
            vc.hidesBottomBarWhenPushed = true
            self.push(vc)
        }
    }
    
     func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
         if textField === searchUserTextField {
             UIView.transition(with: self.searchView, duration: 0.5, options: .allowAnimatedContent
                               , animations: {
                 self.heightSearchView.constant = 5
                 self.tableView.isHidden = true
                 self.userTableView.isHidden = false
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

