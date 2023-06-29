//
//  UserActiveCollectionViewCell.swift
//  MovieApp
//
//  Created by mr.root on 6/28/23.
//

import UIKit

class UserActiveCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageActive: UIImageView!
    @IBOutlet weak var imageAvatar: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        imageActive.cornerRadius(imageActive.frame.height / 2)
        imageActive.setupBoderWidth(with: 2, color: UIColor.white.cgColor)
        
        imageAvatar.cornerRadius(imageAvatar.frame.height / 2)
        imageAvatar.setupBoderWidth(with: 1, color: UIColor.black.cgColor)
    }
    
    func bindData(_ user: UserResponse) {
        nameLabel.text = user.userName ?? ""
        ImageManager.share.fetchImage(with: user.imageUrl ?? "") { [weak self] image in
            guard let `self` = self else { return }
            self.imageAvatar.image = image
        }
        
        imageActive.tintColor = (user.active ?? true) ? .green : .systemGray
    }

}
