//
//  ListUserDataSource.swift
//  MovieApp
//
//  Created by mr.root on 6/29/23.
//

import UIKit

class ListUserDataSource: UITableViewController {
    private var data: [UserResponse] = [UserResponse]()
    
    func setupTableView(_ tableView: UITableView, list: [UserResponse]) {
        self.data = list
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListUserTableViewCell", for: indexPath) as! ListUserTableViewCell
        let item = data[indexPath.row]
        cell.bindData(item)
        cell.selectionStyle = .none
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}
