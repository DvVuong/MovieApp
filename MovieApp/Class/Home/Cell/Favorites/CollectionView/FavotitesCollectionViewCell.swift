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
    
    
    func bindData(with data: Movie) {
        ImageManager.share.fetchImage(with: data.posterPath ?? "") { [weak self] image in
            guard let `self` = self else {return}
            DispatchQueue.main.async {
                self.imageMovie.image = image
            }
        }
    }

}
