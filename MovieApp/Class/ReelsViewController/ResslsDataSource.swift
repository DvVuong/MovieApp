//
//  ResslsDataSource.swift
//  MovieApp
//
//  Created by mr.root on 8/1/23.
//

import Foundation
import UIKit

class ResslsDataSource: UITableViewController {
    
    private var movies: [Movie] = []
    func setTableView(width tableView: UITableView, lists: [Movie]?) {
        guard let lists = lists else {return}
        self.movies = lists
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UpComingTableViewCell.indentifier, for: indexPath) as? UpComingTableViewCell else {return UITableViewCell()}
        let item = movies[indexPath.row]
        cell.bindDataUI(with: item)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}
