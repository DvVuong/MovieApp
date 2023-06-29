//
//  ChatViewDataSource.swift
//  MovieApp
//
//  Created by mr.root on 6/27/23.
//

import UIKit

class ChatViewDataSource: UITableViewController {
    private enum CellType {
        case userActive(model: [UserResponse])
        case message(model: [MessageResponse])
     }
    
    private var data: [MessageResponse] = [MessageResponse]()
    private var userData: [UserResponse] = [UserResponse]()
    private var sections = [CellType]()
    
    func setTableView(_ tableView: UITableView, list: [MessageResponse], userList: [UserResponse]) {
        self.data = list
        self.userData = userList
        
        sections.append(.userActive(model: userData))
        sections.append(.message(model: data))
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch sections[section] {
        case .userActive(_):
            return 1
        case .message(let model):
            return 2
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch sections[indexPath.section] {
        case .userActive(let model):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "UserActiveTableViewCell", for: indexPath) as? UserActiveTableViewCell else {
                return fatalError() as! UITableViewCell
            }
            cell.setupColletionView()
            return cell
        case .message(let model):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "MessageTableViewCell", for: indexPath) as? MessageTableViewCell else {
                return fatalError() as! UITableViewCell
            }
            cell.nameLabel.text = "Admin"
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch sections[indexPath.section] {
        case .userActive:
            return 150
        case .message:
            return UITableView.automaticDimension
        }
    }
}

