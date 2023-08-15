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
    public var actionSelected: ((Movie, Int) -> Void)? = nil
   
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
        return CGSize(width: collectionView.frame.width - 10, height: collectionView.frame.height)
    }
    
     func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
         let item = data[indexPath.row]
         let index = indexPath.row
         actionSelected?(item, index)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let layout = self.collectionView?.collectionViewLayout as! UICollectionViewFlowLayout
        let cellWidthIncludingSpacing = layout.itemSize.width + layout.minimumLineSpacing
        
        var offset = targetContentOffset.pointee
        let index = (offset.x + scrollView.contentInset.left) / cellWidthIncludingSpacing
        let roundedIndex = round(index)
        
        let visibleWidth = scrollView.bounds.size.width
        - scrollView.contentInset.left
        - scrollView.contentInset.right
        
        offset = CGPoint(
            x: roundedIndex * cellWidthIncludingSpacing
            - scrollView.contentInset.left
            + layout.itemSize.width / 1.5
            - visibleWidth / 2,
            y: -scrollView.contentInset.top
        )
        targetContentOffset.pointee = offset
    }
}
