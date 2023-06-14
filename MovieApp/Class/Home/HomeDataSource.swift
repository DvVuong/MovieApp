//
//  HomeDataSourece.swift
//  MovieApp
//
//  Created by BeeTech on 13/06/2023.
//

import UIKit

class HomeDataSource: UITableViewController {
    
    enum CellType {
        case category
        case detail
        case recent
        case favorites
    }
    
    var sections: [CellType] = [
        .category,
        .detail,
        .recent,
        .favorites
    ]
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch sections[section] {
        case .category:
            return 1
        case .detail:
            return 1
        case .recent:
            return 1
        case .favorites:
            return 1
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch sections[indexPath.section] {
        case .category:
            let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryTableViewCell", for: indexPath) as! CategoryTableViewCell
            cell.actionMovies = { [weak self]  in
                //Todo here
            }
            cell.actionTVShows = { [weak self]  in
                //Todo here
            }
            cell.actionAnime = { [weak self]  in
                //Todo here
            }
            cell.actionMyList = { [weak self]  in
                //Todo here
            }
            cell.selectionStyle = .none
            
            return cell
        case .detail:
            let cell = tableView.dequeueReusableCell(withIdentifier: "DetailTableViewCell", for: indexPath) as! DetailTableViewCell
            cell.setupCollectionView()
            cell.selectionStyle = .none
            return cell
        case .recent:
            let cell = tableView.dequeueReusableCell(withIdentifier: "RecentTableViewCell", for: indexPath) as! RecentTableViewCell
            cell.setupCollectionView()
            cell.selectionStyle = .none
            return cell
        case .favorites:
            let cell = tableView.dequeueReusableCell(withIdentifier: "FavoritesTableViewCell", for: indexPath) as! FavoritesTableViewCell
            cell.setupCollectionView()
            cell.selectionStyle = .none
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch sections[indexPath.section] {
        case .category:
            return UITableView.automaticDimension
        case .detail:
            return UITableView.automaticDimension
        case .recent:
            return 230
        case .favorites:
            return 230
        }
    }
}
