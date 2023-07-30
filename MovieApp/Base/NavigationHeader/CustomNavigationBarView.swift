//
//  CustomNavigationBarView.swift
//  MovieApp
//
//  Created by mr.root on 7/30/23.
//

import UIKit
import SnapKit

class CustomNavigationBarView: UIView {
    lazy var textLabel = CustomLabel()
    lazy var avatarImage = UIImageView()
    lazy var titleLabel = CustomLabel()
    lazy var notificationImage = UIImageView()
    private var heightContrains: CGFloat = 0
    
    var heightAvatarImage: CGFloat = 30 {
        willSet {
            heightContrains = newValue
        }
    }
    
    override init(frame: CGRect) {
          super.init(frame: frame)
          self.setupUI()
      }
      
      required init?(coder aDecoder: NSCoder) {
          super.init(coder: aDecoder)
          self.setupUI()
      }
    
    private func setupUI() {
        textLabel.textColor = .white
        textLabel.backgroundColor  = .blue
        textLabel.numberOfLines = 0
        textLabel.cornerRadius(10)
        avatarImage.contentMode = .scaleAspectFill
        avatarImage.cornerRadius(heightAvatarImage / 2)
        notificationImage.cornerRadius(10)
        notificationImage.setupBoderWidth(with: 1, color: UIColor.black.cgColor)
        notificationImage.contentMode = .scaleAspectFill
    }
    
    func setupCustomUI() {
        addSubview(titleLabel)
        addSubview(textLabel)
        addSubview(avatarImage)
        addSubview(notificationImage)
        
        notificationImage.image = UIImage(systemName: "bell")
        notificationImage.tintColor = .white
        notificationImage.backgroundColor = .systemGray
            
        titleLabel.text = "Hello,"
        titleLabel.font = .systemFont(ofSize: 12, weight: .semibold)
        titleLabel.numberOfLines = 1
        
        textLabel.numberOfLines = 1
        textLabel.cornerRadius(10)
        textLabel.backgroundColor  = .clear
        
        avatarImage.setupBoderWidth(with: 1, color: UIColor.black.cgColor)
        avatarImage.contentMode = .scaleAspectFill
        avatarImage.cornerRadius(heightAvatarImage / 2)
        
        avatarImage.setContentHuggingPriority(.defaultLow, for: .horizontal)
        avatarImage.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        
        textLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
        textLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        
        textLabel.setContentHuggingPriority(.defaultLow, for: .vertical)
        textLabel.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        
        titleLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        titleLabel.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        
        titleLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
        titleLabel.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        
        avatarImage.snp.makeConstraints { make in
            make.width.height.equalTo(heightAvatarImage)
            make.leading.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-2)
        }
        
        textLabel.snp.makeConstraints { make in
            make.top.lessThanOrEqualTo(titleLabel.snp.bottom).offset(1)
            make.bottom.equalToSuperview().offset(-1)
            make.leading.greaterThanOrEqualTo(avatarImage.snp.trailing).offset(5)
            make.width.lessThanOrEqualTo(250)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(2)
            make.bottom.greaterThanOrEqualTo(textLabel.snp.top).offset(-2)
            make.leading.greaterThanOrEqualTo(avatarImage.snp.trailing).offset(5)
            make.width.lessThanOrEqualTo(150)
        }
        
        notificationImage.snp.makeConstraints { make in
            make.width.height.equalTo(heightContrains - 5)
            make.trailing.equalToSuperview().offset(-10)
            make.centerY.equalToSuperview()
        }
        
        updateConstraintsIfNeeded()
    }
}

