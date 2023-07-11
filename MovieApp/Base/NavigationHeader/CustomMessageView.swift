//
//  CustomMessageView.swift
//  MovieApp
//
//  Created by mr.root on 7/2/23.
//

import UIKit
import SnapKit

class CustomMessageView: UIView {
    lazy var textLabel = CustomLabel()
    lazy var avatarImage = UIImageView()
    
    private let heightAvatarImage: CGFloat = 30
    
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
        textLabel.cornerRadius(8)
        avatarImage.contentMode = .scaleAspectFill
        avatarImage.cornerRadius(heightAvatarImage / 2)
    }
    
    func setupForSenderUser(with senderUser: MessageResponse) {
        addSubview(textLabel)
        addSubview(avatarImage)
        
        textLabel.text = senderUser.text
        avatarImage.image = Asset.spaceArtWallpapers.image
        
//        ImageManager.share.fetchImage(with: senderUser.senderAvatar ?? "") { image in
//            self.avatarImage.image = image
//        }
        
        avatarImage.snp.makeConstraints { make in
            make.width.height.equalTo(heightAvatarImage)
            make.trailing.equalToSuperview().offset(-10)
            make.bottom.equalToSuperview().offset(-5)
        }
        
        textLabel.snp.makeConstraints { make in
            make.top.equalTo(5)
            make.bottom.equalTo(-5)
            make.trailing.greaterThanOrEqualTo(avatarImage.snp.leading).offset(-10)
            make.width.lessThanOrEqualTo(250)
        }
        updateConstraintsIfNeeded()
    }
    
    func setupForReciverUser(_ reciverUser: MessageResponse) {
        addSubview(textLabel)
        addSubview(avatarImage)
        
        textLabel.text = reciverUser.text ?? ""
        avatarImage.image = Asset.spaceArtWallpapers.image
        
        avatarImage.snp.makeConstraints { make in
            make.width.height.equalTo(heightAvatarImage)
            make.leading.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-5)
        }
        
        textLabel.snp.makeConstraints { make in
            make.top.equalTo(5)
            make.bottom.equalTo(-5)
            make.leading.greaterThanOrEqualTo(avatarImage.snp.trailing).offset(5)
            make.width.lessThanOrEqualTo(250)
        }
        updateConstraintsIfNeeded()
    }
}

