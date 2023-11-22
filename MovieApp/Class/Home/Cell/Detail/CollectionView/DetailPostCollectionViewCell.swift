//
//  DetailPostCollectionViewCell.swift
//  MovieApp
//
//  Created by BeeTech on 13/06/2023.
//

import UIKit
import FSPagerView

class DetailPostCollectionViewCell: FSPagerViewCell {
    @IBOutlet weak var imageMovies: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
    }
    
    private func setupUI() {
        contentView.backgroundColor = .clear
        nameLabel.textColor = .white
        imageMovies.cornerRadius(10)
        imageMovies.contentMode = .scaleAspectFill
        imageMovies.clipsToBounds = true
    }
    
    func bindData(with data: Movie) {
        nameLabel.text = data.title
        ImageManager.share.fetchImage(with: data.posterPath ?? "" , completion: {[weak self] image in
            guard let `self` = self else {return}
            DispatchQueue.main.async {
                self.imageMovies.image = image
            }
        })
    }
}
