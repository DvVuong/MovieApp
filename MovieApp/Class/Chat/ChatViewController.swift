//
//  ChatViewController.swift
//  MovieApp
//
//  Created by mr.root on 6/21/23.
//

import UIKit

class ChatViewController: BaseViewController {
    @IBOutlet weak var headerView: CustomNavigationHeader!
    @IBOutlet weak var tableView: UITableView!
    private let dataSource: ChatViewDataSource = ChatViewDataSource()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTableView()
    }
    
    override func setupUI() {
        headerView.defaultItem()
        headerView.title = "Chat"
    }
    
    override func setupViewModel() {
        
    }
    
    private func setupTableView() {
        var messageArr = [MessageResponse]()
        var userArry = [UserResponse]()
        tableView.delegate = dataSource
        tableView.dataSource = dataSource
        let arr1 = MessageResponse(text: "a",
                                   time: 0,
                                   nameSender: "d",
                                   idSender: "d",
                                   reciveName: "a",
                                   idRecive: "d",
                                   imageurl: "d")
        
        messageArr.append(arr1)
        
        let arr2 = UserResponse(email: "asd",
                                id: "d",
                                userName: "s",
                                active: true,
                                imageUrl: "d")
        
        userArry.append(arr2)
        dataSource.setTableView(tableView, list: messageArr, userList: userArry)
        tableView.register(UINib(nibName: "UserActiveTableViewCell", bundle: nil), forCellReuseIdentifier: "UserActiveTableViewCell")
        tableView.register(UINib(nibName: "MessageTableViewCell", bundle: nil), forCellReuseIdentifier: "MessageTableViewCell")
    }
}
