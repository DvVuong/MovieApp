//
//  TheCastCollectionViewCell.swift
//  MovieApp
//
//  Created by BeeTech on 15/06/2023.
//

import UIKit

class TheCastCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageTheCast: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupImage()
    }
    
    private func setupImage() {
        imageTheCast.cornerRadius(10)
    }

}
