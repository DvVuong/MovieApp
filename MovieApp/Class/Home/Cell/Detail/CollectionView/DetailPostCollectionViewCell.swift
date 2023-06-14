//
//  DetailPostCollectionViewCell.swift
//  MovieApp
//
//  Created by BeeTech on 13/06/2023.
//

import UIKit

class DetailPostCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageMovies: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
    }
    
    func setupUI() {
        imageMovies.cornerRadius(10)
    }

}
