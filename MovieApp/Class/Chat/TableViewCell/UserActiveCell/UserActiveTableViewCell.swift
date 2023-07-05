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
    public var reciverUser: ((UserResponse) -> Void)? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
    func setupColletionView(_ list: [UserResponse]) {
        collectionView.delegate = dataSoure
        collectionView.dataSource = dataSoure
        collectionView.register(UINib(nibName: "UserActiveCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "UserActiveCollectionViewCell")
        dataSoure.setDataSource(collectionView, list: list)
        collectionView.reloadData()
    }
    
    func didChooserReciverUser() {
        dataSoure.didTapItem = { [weak self] item in
            guard let `self`  = self else {return}
            self.reciverUser?(item)
        }
    }
    
}
