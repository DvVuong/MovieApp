//
//  UserActiveDataSource.swift
//  MovieApp
//
//  Created by mr.root on 6/28/23.
//

import Foundation
import UIKit

class UserActiveDataSource: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    public var didTapItem: ((UserResponse) -> Void)? = nil
    
    private var data: [UserResponse] = [UserResponse]()
    func setDataSource(_ collectionView: UICollectionView, list: [UserResponse]) {
        self.data = list
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UserActiveCollectionViewCell", for: indexPath) as! UserActiveCollectionViewCell
        let item = data[indexPath.row]
        cell.bindData(item)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 120, height: 120)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = data[indexPath.row]
        didTapItem?(item)
    }
}
