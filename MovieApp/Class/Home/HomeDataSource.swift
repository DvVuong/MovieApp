//
//  HomeDataSourece.swift
//  MovieApp
//
//  Created by BeeTech on 13/06/2023.
//

import UIKit
protocol HomeDataSourceDelegate: AnyObject {
    func willHideTabbar()
    func willShowTabbar()
    func showTabBar()
}

class HomeDataSource: UITableViewController {
    
    private var startContentOffset: CGFloat!
    private var lastContentOffset: CGFloat!
    
    public var actionMoveToDetaiView:((Movie) -> Void)? = nil
    public var handlerActionScroll: (() -> Void)? = nil
    public var indexPath: ((IndexPath) -> Void)? = nil
    
    weak var delegate: HomeDataSourceDelegate?
    
    func setupTableView(width tableView: UITableView, list: [Movie]? = nil, listTopRate: [Movie]? = nil, listOnTheAir: [Movie]? = nil) {
        sections.append(.category)
        sections.append(.detail(model: list ?? []))
        sections.append(.recent(model: listTopRate ?? []))
        sections.append(.favorites(model: listOnTheAir ?? []))
    }
    
    private enum CellType {
        case category
        case detail(model: [Movie])
        case recent(model: [Movie])
        case favorites(model: [Movie])
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
        case .recent(let models):
            self.indexPath?(indexPath)
            let cell = tableView.dequeueReusableCell(withIdentifier: "RecentTableViewCell", for: indexPath) as! RecentTableViewCell
            cell.setupCollectionView(with: models)
            cell.selectionStyle = .none
            return cell
        case .favorites(let models):
            self.indexPath?(indexPath)
            let cell = tableView.dequeueReusableCell(withIdentifier: "FavoritesTableViewCell", for: indexPath) as! FavoritesTableViewCell
            cell.setupCollectionView(with: models)
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
            return 30
        }
    }
    
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
    
    override func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
          let contentOffsetY = scrollView.contentOffset.x
          self.startContentOffset = contentOffsetY
          self.lastContentOffset = contentOffsetY
      }
      
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
          let currentOffset = scrollView.contentOffset.x
          let differentFromStart = self.startContentOffset - currentOffset
          let differentFromLast = self.lastContentOffset - currentOffset
          self.lastContentOffset = currentOffset
          if (differentFromStart < 0) {
              if (scrollView.isTracking && abs(differentFromLast) > 1) {
                  delegate?.willHideTabbar()
              }
          } else {
              if (scrollView.isTracking && (abs(differentFromLast) > 1)) {
                  delegate?.willShowTabbar()
              }
          }
      }
      
    override func scrollViewShouldScrollToTop(_ scrollView: UIScrollView) -> Bool {
        delegate?.showTabBar()
        return true
    }
    
//    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        delegate?.handlerActionScroll()
//    }
    
//    override func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
//        delegate?.handlerActionScroll()
//    }
//
//    override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
//        delegate?.handelEndActionScroll()
//    }
}

extension HomeDataSource: CustomHeaderViewDelegate {
    func didTapButton() {
        print("vuongdv Tap Tap Tap")
    }
}
