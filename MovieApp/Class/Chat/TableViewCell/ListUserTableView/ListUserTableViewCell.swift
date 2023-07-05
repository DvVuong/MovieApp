//
//  ListUserTableViewCell.swift
//  MovieApp
//
//  Created by mr.root on 6/29/23.
//

import UIKit

class ListUserTableViewCell: UITableViewCell {
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var nameUser: UILabel!
    @IBOutlet weak var stateImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        avatarImage.cornerRadius(avatarImage.frame.height / 2)
        avatarImage.setupBoderWidth(with: 2, color: UIColor.black.cgColor)
        stateImage.cornerRadius(stateImage.frame.height / 2)
        stateImage.setupBoderWidth(with: 2, color: UIColor.white.cgColor)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func bindData(_ user: UserResponse){
        nameUser.text = user.userName
        stateImage.tintColor = (user.active ?? true) ? .green : .systemGray
        
        ImageManager.share.fetchImage(with: user.imageUrl ?? "") { [weak self] image in
            guard let `self` = self else { return }
            self.avatarImage.image = image
        }
    }
}
