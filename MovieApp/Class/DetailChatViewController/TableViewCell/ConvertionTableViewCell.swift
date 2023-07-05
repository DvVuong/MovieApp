//
//  ConvertionTableViewCell.swift
//  MovieApp
//
//  Created by mr.root on 7/2/23.
//

import UIKit

class ConvertionTableViewCell: UITableViewCell {
    @IBOutlet weak var contenview: CustomMessageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func bindData(_ message: MessageResponse) {
        contenview.setupForReciverUser(message)
    }
    
}
