//
//  DetailDataSource.swift
//  MovieApp
//
//  Created by mr.root on 7/2/23.
//


import UIKit
class DetailDataSource: UITableViewController {
    
    private var data = [MessageResponse]()
    
    func setupTableView(_ tabelView: UITableView, list: [MessageResponse]) {
        data = list
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ConvertionTableViewCell", for: indexPath) as! ConvertionTableViewCell
        let item = data[indexPath.row]
        cell.bindData(item)
        return cell
    }
}
