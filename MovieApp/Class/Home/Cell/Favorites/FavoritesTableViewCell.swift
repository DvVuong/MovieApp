//
//  FavoritesTableViewCell.swift
//  MovieApp
//
//  Created by BeeTech on 13/06/2023.
//

import UIKit

protocol FavoritesTableViewCellDelegate: AnyObject {
    func didChooseFavoriteItem(with item: Movie)
}

class FavoritesTableViewCell: UITableViewCell {
    @IBOutlet weak var collectionView: UICollectionView!
    
    weak var delegate: FavoritesTableViewCellDelegate?
    private var dataSource = FavoritesDataSource()
    private var data: [Movie] = []
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setupCollectionView(with items: [Movie]) {
        self.data = items
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "FavotitesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "FavotitesCollectionViewCell")
        collectionView.reloadData()
    }
}

extension FavoritesTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
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
        delegate?.didChooseFavoriteItem(with: item)
    }
}
