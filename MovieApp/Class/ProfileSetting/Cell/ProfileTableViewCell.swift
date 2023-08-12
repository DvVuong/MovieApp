//
//  ProfileTableViewCell.swift
//  MovieApp
//
//  Created by BeeTech on 16/06/2023.
//

import UIKit
import SnapKit

class ProfileTableViewCell: UITableViewCell {
    private lazy var titelLabel: UILabel = {
       let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.textAlignment = .left
        return title
    }()

    public var handelButton: (() -> Void)? = nil
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        configgure()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func configgure() {
        contentView.addSubview(titelLabel)
        
        titelLabel.snp.makeConstraints { make in
            make.leading.equalTo(contentView.snp.leading).offset(5)
            make.centerY.equalTo(contentView.snp.centerY)
            make.width.lessThanOrEqualTo(200)
        }
        
        updateConstraintsIfNeeded()
        
    }
    
    func bindData(with text: String?) {
        guard let `text` = text else {return}
        titelLabel.text = text
    }
    
    @objc private func didTapButton(_ sender: UIButton) {
        handelButton?()
    }
    
}
