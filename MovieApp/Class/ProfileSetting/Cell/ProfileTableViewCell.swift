//
//  ProfileTableViewCell.swift
//  MovieApp
//
//  Created by BeeTech on 16/06/2023.
//

import UIKit

class ProfileTableViewCell: UITableViewCell {
    @IBOutlet weak var titelLabel: UILabel!
    @IBOutlet weak var button: UIButton!
    
    
    public var handelButton: (() -> Void)? = nil
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        button.addTarget(self, action: #selector(didTapButton(_:)), for: .touchUpInside)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @objc private func didTapButton(_ sender: UIButton) {
        handelButton?()
    }
    
}
