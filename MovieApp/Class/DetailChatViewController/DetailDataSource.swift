//
//  DetailDataSource.swift
//  MovieApp
//
//  Created by mr.root on 7/2/23.
//


import UIKit
class DetailDataSource: UITableViewController {
    
//    var messageArrays: [MessageResponse]? = nil {
//        didSet {
//           data = messageArrays ?? []
//
//            tableView.reloadData()
//        }
//    }
    
    private var data = [MessageResponse]()
    
    func setupTableView(_ tabelView: UITableView, list: [MessageResponse]) {
        data = list
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let currentId = UserDefaultManager.shared.currentUserId
        let item = data[indexPath.row]
        if item.typeMessage == 0 {
            if item.idSender == currentId {
                let cell = tableView.dequeueReusableCell(withIdentifier: "ConvertionTableViewCell", for: indexPath) as! ConvertionTableViewCell
                cell.bindData(item)
                return cell
            }else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "ReciverUserTableViewCell", for: indexPath) as! ReciverUserTableViewCell
                cell.bindDataToView(with: item)
                return cell
            }
        }else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ImageTableViewCell", for: indexPath) as! ImageTableViewCell
            cell.bindData(with: item.imageUrl ?? "")
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let item = data[indexPath.row]
        if item.typeMessage == 0 {
            return UITableView.automaticDimension
        }else {
            return 200 / (item.ratioImage ?? 1)
        }
    }
}
