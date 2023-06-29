//
//  UserActiveDataSource.swift
//  MovieApp
//
//  Created by mr.root on 6/28/23.
//

import Foundation
import UIKit

class UserActiveDataSource: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    private var data: [UserResponse] = [UserResponse]()
    func setDataSource(_ collectionView: UICollectionView, list: [UserResponse]) {
        self.data = list
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UserActiveCollectionViewCell", for: indexPath) as! UserActiveCollectionViewCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 120, height: 120)
    }
}
