//
//  CustomHeaderView.swift
//  MovieApp
//
//  Created by mr.root on 7/28/23.
//

import Foundation
import UIKit
import SnapKit

protocol CustomHeaderViewDelegate: AnyObject {
    func didTapButton() 
}

class CustomHeaderView: UITableViewHeaderFooterView {
    static var identifier = "CustomHeader"
    weak var delegate: CustomHeaderViewDelegate?
    lazy var titleLable: UILabel = {
       let title = UILabel()
        title.textColor = .white
        title.translatesAutoresizingMaskIntoConstraints = false
        title.font = .systemFont(ofSize: 20, weight: .semibold)
        return title
    }()
    
    lazy var closeButton: UIButton = {
       let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Close", for: .normal)
        button.addTarget(self, action: #selector(didTapButton(_:)), for: .touchUpInside)
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .semibold )
        return button
    }()
    
    var buttonValue: String? = nil {
        willSet {
            closeButton.setTitle(newValue, for: .normal)
        }
    }
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupTitleLable()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupTitleLable() {
        addSubview(titleLable)
        addSubview(closeButton)
        
        titleLable.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(15)
            make.centerY.equalToSuperview()
        }
        
        closeButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-15)
            make.centerY.equalToSuperview()
        }
        
        updateConstraintsIfNeeded()
    }
    @objc private func didTapButton(_ sender: UIButton) {
        delegate?.didTapButton()
    }
}
