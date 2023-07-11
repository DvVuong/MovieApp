//
//  ReciverUserTableViewCell.swift
//  MovieApp
//
//  Created by mr.root on 7/10/23.
//

import UIKit

class ReciverUserTableViewCell: UITableViewCell {
    @IBOutlet weak var bubbelView: CustomMessageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func bindDataToView(with message: MessageResponse) {
        bubbelView.setupForReciverUser(message)
    }
}
