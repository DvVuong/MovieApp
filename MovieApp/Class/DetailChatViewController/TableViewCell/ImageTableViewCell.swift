//
//  ImageTableViewCell.swift
//  MovieApp
//
//  Created by mr.root on 7/13/23.
//

import UIKit

class ImageTableViewCell: UITableViewCell {

    @IBOutlet weak var imagemessgae: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        imagemessgae.cornerRadius(8)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func bindData(with imageUrl: String) {
        ImageManager.share.fetchImage(with: imageUrl) { [weak self] image in
            guard let `self` = self else {return}
            DispatchQueue.main.async {
                self.imagemessgae.image = image
            }
        }
    }
}
