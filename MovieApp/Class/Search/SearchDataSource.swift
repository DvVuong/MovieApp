//
//  SearchDataSource.swift
//  MovieApp
//
//  Created by mr.root on 8/9/23.
//

import Foundation
import UIKit
protocol SearchDataSourceDelegate: AnyObject {
    func didChooseItem(with item: Movie)
}

class SearchDataSource: UITableViewController {
    
    private var data: [Movie] = []
    weak var delegate: SearchDataSourceDelegate?
    
    func setTableView(with tableView: UITableView, lists: [Movie]?) {
        guard let lists = lists else {return}
        self.data = lists
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell", for: indexPath) as? MovieTableViewCell else {return UITableViewCell()}
        let item = data[indexPath.row]
        cell.bindData(with: item)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = data[indexPath.row]
        delegate?.didChooseItem(with: item)
    }
}
