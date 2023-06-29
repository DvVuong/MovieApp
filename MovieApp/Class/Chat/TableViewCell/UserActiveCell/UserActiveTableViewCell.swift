//
//  UserActiveTableViewCell.swift
//  MovieApp
//
//  Created by mr.root on 6/28/23.
//

import UIKit

class UserActiveTableViewCell: UITableViewCell {
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var dataSoure: UserActiveDataSource = UserActiveDataSource()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupColletionView() {
        collectionView.delegate = dataSoure
        collectionView.dataSource = dataSoure
        collectionView.register(UINib(nibName: "UserActiveCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "UserActiveCollectionViewCell")
        let u1 = UserResponse(email: "la la la", id: "ad", userName: " la la la")
        var arr = [UserResponse]()
        arr.append(u1)
        
        dataSoure.setDataSource(collectionView, list: arr)
    }
    
}
