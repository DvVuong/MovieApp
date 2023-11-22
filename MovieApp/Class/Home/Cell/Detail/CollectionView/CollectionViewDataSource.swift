//
//  DataSource.swift
//  MovieApp
//
//  Created by BeeTech on 13/06/2023.
//

import UIKit
import Foundation

class CollectionViewDataSource: NSObject, UICollectionViewDelegate, UICollectionViewDataSource {
    
    public var didSelectedItemHandler: (() -> Void)? = nil
    private var data: [Movie] = []
    
    func setupCollectionView(with collectionView: UICollectionView, list: [Movie]) {
        self.data = list
    }
    
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
        print("vuongdv he he eh")
        return CGSize(width: 1, height: 450)
    }
     func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       didSelectedItemHandler?()
    }
}
