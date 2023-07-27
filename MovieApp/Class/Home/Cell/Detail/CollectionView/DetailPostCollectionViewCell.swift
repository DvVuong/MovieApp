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
    
    private func setupUI() {
        imageMovies.cornerRadius(10)
        imageMovies.contentMode = .scaleAspectFill
    }
    
    func bindData(with data: Movie) {
        nameLabel.text = data.name
        titleLabel.text = "\(String(describing: data.year))"
        ImageManager.share.fetchImage(with: data.i?.imageUrl ?? "", completion: {[weak self] image in
            guard let `self` = self else {return}
            DispatchQueue.main.async {
                self.imageMovies.image = image
            }
        })
    }

}
