//
//  ChatViewDataSource.swift
//  MovieApp
//
//  Created by mr.root on 6/27/23.
//

import UIKit

class ChatViewDataSource: UITableViewController {
    public var didGetReciverUser: ((UserResponse) -> Void)? = nil
    private enum CellType {
        case userActive
        case message
     }
    
    private var userData: [UserResponse] = [UserResponse]()
    private var data: [MessageResponse] = [MessageResponse]()
    private var sections: [CellType] = [
        .userActive,
        .message
    ]
    
    func setTableView(_ tableView: UITableView, userList: [UserResponse]) {
        self.userData = userList
    }
    
    func setTableView(_ tableView: UITableView, listMessage: [MessageResponse]) {
        self.data = listMessage
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch sections[section] {
        case .userActive:
            return 1
        case .message:
            return data.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch sections[indexPath.section] {
        case .userActive:
             let cell = tableView.dequeueReusableCell(withIdentifier: "UserActiveTableViewCell", for: indexPath) as! UserActiveTableViewCell
            cell.setupColletionView(self.userData)
            cell.didChooserReciverUser()
            cell.reciverUser = {[weak self] user in
                guard let `self` = self else {return}
                self.didGetReciverUser?(user)
            }
            cell.selectionStyle = .none
            return cell
        case .message:
             let cell = tableView.dequeueReusableCell(withIdentifier: "MessageTableViewCell", for: indexPath) as! MessageTableViewCell
            cell.bindData(data[indexPath.row])
            cell.selectionStyle = .none
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

