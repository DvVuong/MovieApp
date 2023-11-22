//
//  DetailTableViewCell.swift
//  MovieApp
//
//  Created by BeeTech on 13/06/2023.
//

import UIKit
import FSPagerView

class DetailTableViewCell: UITableViewCell {
  
    @IBOutlet weak var pageView: FSPagerView!
    
    public var actionSelected: ((Movie, Int) -> Void)? = nil
   
    var data: [Movie] = []

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupCollectionView(with list: [Movie]) {
        self.data = list
        pageView.delegate = self
        pageView.dataSource = self
        pageView.transformer = FSPagerViewTransformer(type: .linear)
        pageView.register(UINib(nibName: "DetailPostCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "DetailPostCollectionViewCell")
        pageView.reloadData()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

extension DetailTableViewCell: FSPagerViewDelegate, FSPagerViewDataSource {
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return self.data.count
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "DetailPostCollectionViewCell", at: index) as! DetailPostCollectionViewCell
        let item = data[index]
        cell.bindData(with: item)
        return cell
    }
    
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        let item = data[index]
        actionSelected?(item, index)
    }
    
    
//
//     func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//         let item = data[indexPath.row]
//         let index = indexPath.row
//         actionSelected?(item, index)
//    }
//
    
}
