//
//  TheCastDataSource.swift
//  MovieApp
//
//  Created by BeeTech on 15/06/2023.
//

import UIKit
class TheCastDataSource: UICollectionViewController, UICollectionViewDelegateFlowLayout {
//    override func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return 2
//    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TheCastCollectionViewCell", for: indexPath) as! TheCastCollectionViewCell
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HeaderCell", for: indexPath) as! HeaderCell
            header.actionSeeAll = { [weak self] in
                guard let `self` = self else { return }
                        print("See all")
            }
            return header
            
        default:
            break
        }
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 80, height: 80)
    }
}
