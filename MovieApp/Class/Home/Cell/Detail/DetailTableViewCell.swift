//
//  DetailTableViewCell.swift
//  MovieApp
//
//  Created by BeeTech on 13/06/2023.
//

import UIKit

class DetailTableViewCell: UITableViewCell {
    @IBOutlet weak var collectionView: UICollectionView!
    private var dataSource = CollectionViewDataSource()
    public var actionSelected: ((Movie) -> Void)? = nil
    
    var data: [Movie] = []

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupCollectionView(with list: [Movie]) {
        self.data = list
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "DetailPostCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "DetailPostCollectionViewCell")
        collectionView.reloadData()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

extension DetailTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.data.count
    }
    
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DetailPostCollectionViewCell", for: indexPath) as! DetailPostCollectionViewCell
        let item = data[indexPath.row]
        cell.bindData(with: item)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width * 2 / 3, height: collectionView.frame.height)
    }
    
     func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
         let item = data[indexPath.row]
         actionSelected?(item)
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        let totalCellWidth: CGFloat = (collectionView.frame.width * 2 / 3) * 3
//        let totalSpacingWidth: CGFloat = 10 * (2)
//        let leftInset = (collectionView.frame.width - CGFloat(totalCellWidth + totalSpacingWidth)) / 2
//        let rightInset = leftInset
//        return UIEdgeInsets(top: 0, left: leftInset, bottom: 0, right: rightInset)
//    }
}
