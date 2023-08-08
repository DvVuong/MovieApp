//
//  TheCastDataSource.swift
//  MovieApp
//
//  Created by BeeTech on 15/06/2023.
//

import UIKit

class TableViewDataSource: UITableViewController {
    
    private var data: Movie?
    private var videos: [Video] = []
    
    private enum TableCellType {
        case description
        case cast(model: [Video])
    }
    
    private var sections: [TableCellType] = [
        
    ]
    
    
    
    func setUpTableView(with tableView: UITableView, lists: Movie) {
        self.data = lists
        sections.append(.description)
    }
    
    func setupTableForTrailer(with tableView: UITableView, list: [Video]?) {
        guard let list = list else {return}
        self.videos = list
        print("vuongdv self.video: \(videos.count)")
        sections.append(.cast(model: videos))
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch sections[section] {
        case .description:
            return 1
        case .cast(let models):
            return models.count
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
        case .cast (let models):
            print("vuongdv the castCell")
            guard let cell = tableView.dequeueReusableCell(withIdentifier: TrailerTableViewCell.indentifer, for: indexPath) as? TrailerTableViewCell else {
                return UITableViewCell()
            }
            let item = models[indexPath.row]
            cell.bindData(with: item)
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch sections[indexPath.section] {
        case .description:
            return UITableView.automaticDimension
        case .cast:
            return 350
        }
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else {return}
        header.textLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        header.textLabel?.frame = CGRect(x: view.bounds.origin.x + 20, y: view.bounds.origin.y, width: 150, height: view.bounds.height)
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch sections[section] {
        case .description:
            return nil
        case .cast(_):
            return "Trailer"
        }
    }
}
