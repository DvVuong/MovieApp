//
//  FavotitesCollectionViewCell.swift
//  MovieApp
//
//  Created by BeeTech on 14/06/2023.
//

import UIKit

class FavotitesCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageMovie: UIImageView!
    @IBOutlet weak var contenView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
    }
    private func setupUI() {
        imageMovie.cornerRadius(15)
        contenView.cornerRadius(18)
    }

}
