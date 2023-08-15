//
//  RecentTableViewCell.swift
//  MovieApp
//
//  Created by BeeTech on 13/06/2023.
//

import UIKit

protocol RecentTableViewCellDelegate: AnyObject {
    func didChooseRecentitem(with item: Movie)
    func canLoadMore()
}

class RecentTableViewCell: UITableViewCell {
    @IBOutlet weak var collectionView: UICollectionView!
    private var dataSource: FavoritesDataSource = FavoritesDataSource()
    private var data: [Movie] = []
    
    weak var delegate: RecentTableViewCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupCollectionView(with items: [Movie]) {
        self.data = items
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "FavotitesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "FavotitesCollectionViewCell")
        collectionView.reloadData()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

extension RecentTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource ,UICollectionViewDelegateFlowLayout {
    
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FavotitesCollectionViewCell", for: indexPath) as! FavotitesCollectionViewCell
        let item = data[indexPath.row]
        cell.bindData(with: item)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = self.data[indexPath.row]
        delegate?.didChooseRecentitem(with: item)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.section == collectionView.numberOfSections - 1 &&
            indexPath.row == collectionView.numberOfItems(inSection: indexPath.section) - 1 {
            delegate?.canLoadMore()
        }
    }
}
