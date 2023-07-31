//
//  FavoritesTableViewCell.swift
//  MovieApp
//
//  Created by BeeTech on 13/06/2023.
//

import UIKit

class FavoritesTableViewCell: UITableViewCell {
    @IBOutlet weak var collectionView: UICollectionView!
    
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
}
