//
//  HomeDataSourece.swift
//  MovieApp
//
//  Created by BeeTech on 13/06/2023.
//

import UIKit
protocol HomeDataSourceDelegate: AnyObject {
    func handlerActionScroll()
    func handelEndActionScroll()
}

class HomeDataSource: UITableViewController {
    
    public var actionMoveToDetaiView:((Movie) -> Void)? = nil
    public var handlerActionScroll: (() -> Void)? = nil
    weak var delegate: HomeDataSourceDelegate?
    private var data: [Movie] = []
    
    func setupTableView(width tableView: UITableView, list: [Movie]) {
        self.data = list
        sections.append(.category)
        sections.append(.detail(model: data))
        sections.append(.recent)
        sections.append(.favorites)
    }
    
    private enum CellType {
        case category
        case detail(model: [Movie])
        case recent
        case favorites
    }
    
    private var sections: [CellType] = [
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
        case .detail(let models):
            let cell = tableView.dequeueReusableCell(withIdentifier: "DetailTableViewCell", for: indexPath) as! DetailTableViewCell
            cell.setupCollectionView(with: models)
            cell.setupActionSelectedItem()
            cell.actionSelected = { [weak self] item  in
                guard let `self` = self else { return }
                self.actionMoveToDetaiView?(item)
            }
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
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch sections[section] {
        case .category:
            return 0
        case .recent:
            return 40
        case .detail:
            return 0
        case .favorites:
            return 40
        }
    }
    
//    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
//        guard let header = view as? UITableViewHeaderFooterView else {return}
//        header.textLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
//        header.textLabel?.frame = CGRect(x: header.bounds.origin.x + 2, y: header.bounds.origin.y, width: 100, height: header.bounds.height)
//    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "CustomHeader") as? CustomHeaderView else {return UIView()}
        header.delegate = self
        header.buttonValue = "Close"
        switch sections[section] {
        case .category:
            header.titleLable.text = ""
        case .detail:
            header.titleLable.text = ""
        case .recent:
            header.titleLable.text = "Recent Watched"
        case .favorites:
            header.titleLable.text = "My Favorites"
        }
        return header
    }

//    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        switch sections[section] {
//        case .category:
//            return nil
//        case .recent:
//            return "Recent Wathched"
//        case .detail:
//            return nil
//        case .favorites:
//            return "My Favorites"
//        }
//    }
    
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
    
//    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        delegate?.handlerActionScroll()
//    }
    
    override func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        delegate?.handlerActionScroll()
    }
    
    override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        delegate?.handelEndActionScroll()
    }
}

extension HomeDataSource: CustomHeaderViewDelegate {
    func didTapButton() {
        print("vuongdv Tap Tap Tap")
    }
}
