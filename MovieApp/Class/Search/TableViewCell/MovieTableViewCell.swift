//
//  MovieTableViewCell.swift
//  MovieApp
//
//  Created by mr.root on 8/9/23.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    @IBOutlet weak var imageMovie: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var countStarLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        imageMovie.cornerRadius(10)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func bindData(with movie: Movie) {
        nameLabel.text = movie.title ?? ""
        overviewLabel.text = movie.overview ?? ""
        countStarLabel.text = "\(Int(movie.voteAverage ?? 0))"
        
        ImageManager.share.fetchImage(with: movie.posterPath ?? "") { [weak self] image in
            guard let `self` = self else {return}
            DispatchQueue.main.async {
                self.imageMovie.image = image
            }
        }
    }
    
}
