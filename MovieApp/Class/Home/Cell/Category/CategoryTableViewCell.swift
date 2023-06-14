//
//  CategoryTableViewCell.swift
//  MovieApp
//
//  Created by BeeTech on 13/06/2023.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {
    @IBOutlet var button: [UIButton]!

    
    public var actionMovies: (() -> Void)? = nil
    public var actionTVShows: (() -> Void)? = nil
    public var actionAnime: (() -> Void)? = nil
    public var actionMyList: (() -> Void)? = nil
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupButton()
    }
    
    private func setupButton() {
        button.forEach { button in
            button.addTarget(self, action: #selector(didTapButton(_:)), for: .touchUpInside)
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @objc private func didTapButton(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            actionMovies?()
        case 1:
            actionTVShows?()
        case 2:
            actionAnime?()
        case 3:
            actionMyList?()
        default:
            break
        }
    }
    
}
