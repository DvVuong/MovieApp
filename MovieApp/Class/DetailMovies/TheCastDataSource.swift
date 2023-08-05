//
//  TheCastDataSource.swift
//  MovieApp
//
//  Created by BeeTech on 15/06/2023.
//

import UIKit

class TableViewDataSource: UITableViewController {
    
    private enum TableCellType {
        case description
        case cast
    }
    
    private var sections: [TableCellType] = [
        .description,
        .cast
    ]
    
    private var data: Movie?
    
    func setUpTableView(with tableView: UITableView, lists: Movie) {
        self.data = lists
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch sections[section] {
        case .description:
            return 1
        case .cast:
            return 1
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch sections[indexPath.section] {
        case .description:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: DesciptionTableCell.indentifier, for: indexPath) as? DesciptionTableCell else {
                return UITableViewCell()
            }
            cell.bindData(with: self.data)
            return cell
        case .cast:
            let cell = tableView.dequeueReusableCell(withIdentifier: DetailMovieTableViewCell.indentifier, for: indexPath)
            //cell.textLabel?.text = data?.originalTitle ?? ""
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
