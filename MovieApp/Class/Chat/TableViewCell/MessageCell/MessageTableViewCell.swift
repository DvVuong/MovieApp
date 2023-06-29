//
//  MessageTableViewCell.swift
//  MovieApp
//
//  Created by mr.root on 6/21/23.
//

import UIKit

class MessageTableViewCell: UITableViewCell {
    @IBOutlet weak var imageAvatar: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var imageActive: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        imageAvatar.cornerRadius(imageAvatar.frame.height / 2)
        imageAvatar.setupBoderWidth(with: 1, color: UIColor.black.cgColor)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func bindData() {
        
    }
}
