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
    public var actionSelected: (() -> Void)? = nil
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupActionSelectedItem()
    }
    
    func setupCollectionView() {
        collectionView.delegate = dataSource
        collectionView.dataSource = dataSource
        collectionView.register(UINib(nibName: "DetailPostCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "DetailPostCollectionViewCell")
    }
    
    func setupActionSelectedItem() {
        dataSource.didSelectedItemHandler = { [weak self] in
            guard let `self` = self else { return }
            self.actionSelected?()
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
