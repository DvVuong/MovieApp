//
//  CustomNavigationHeader.swift
//  MovieApp
//
//  Created by mr.root on 6/26/23.
//

import Foundation
import UIKit
import SnapKit


class CustomNavigationHeader: UIView {
    lazy var backButton: UIButton = {
       let button = UIButton()
        button.setImage(Asset.icons8BackBlack.image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var titleLabel: UILabel = {
        let title = UILabel()
        title.text = ""
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    var title: String?  {
        get {
            return titleLabel.text 
        }
        set {
            return titleLabel.text = newValue ?? ""
        }
    }
    
   func defaultItem() {
        addSubview(backButton)
        addSubview(titleLabel)
        
        backButton.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        backButton.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        
        titleLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        titleLabel.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        
        backButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.width.equalTo(30)
            make.height.equalTo(30)
            make.leading.equalToSuperview().offset(20)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.centerX.equalToSuperview()
        }
        
       updateConstraintsIfNeeded()
    }

    func customItemView(with leftButton: UIButton, title: UILabel) {
        addSubview(leftButton)
        addSubview(title)
        
        leftButton.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        leftButton.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        
        title.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        title.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        
        leftButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.width.equalTo(30)
            make.height.equalTo(30)
            make.leading.equalToSuperview().offset(20)
        }
        
        title.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.centerX.equalToSuperview()
        }
        
    }
}
