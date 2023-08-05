//
//  UpComingTableViewCell.swift
//  MovieApp
//
//  Created by mr.root on 8/1/23.
//

import Foundation
import UIKit
import SnapKit

class UpComingTableViewCell: UITableViewCell {
    static var indentifier = "UpComingTableViewCell"
    
    private lazy var imageMovie: UIImageView = {
       let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var titleLable: UILabel = {
       let title = UILabel()
        title.numberOfLines = 0
        title.textColor = .black
        title.translatesAutoresizingMaskIntoConstraints = false
        title.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        return title
    }()
    
    private lazy var buttonPlay: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "play.circle", withConfiguration: UIImage.SymbolConfiguration(pointSize: 30))
        button.setImage(image, for: .normal)
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //imageMovie.cornerRadius(20)
    }
    
    
    private func setupUI() {
        contentView.addSubview(imageMovie)
        contentView.addSubview(titleLable)
        contentView.addSubview(buttonPlay)
        
        imageMovie.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        imageMovie.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        titleLable.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        titleLable.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        buttonPlay.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        buttonPlay.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        
        imageMovie.snp.makeConstraints { make in
            make.leading.equalTo(contentView.snp.leadingMargin).offset(30)
            make.top.equalTo(contentView.snp.top).offset(5)
            make.bottom.equalTo(contentView.snp.bottom).offset(-5)
            make.width.equalTo(50)
        }
        
        titleLable.snp.makeConstraints { make in
            make.leading.equalTo(imageMovie.snp.trailingMargin).offset(35)
            make.centerY.equalTo(contentView.snp.centerY)
            make.trailing.equalTo(buttonPlay.snp.leading).offset(-10)
        }

        buttonPlay.snp.makeConstraints { make in
            make.centerY.equalTo(contentView.snp.centerY)
            make.width.equalTo(50)
            make.trailing.equalTo(contentView.snp.trailing).offset(-30)
        }
        
        updateConstraintsIfNeeded()
    }
    
    func bindDataUI(with movie: Movie) {
        titleLable.text = movie.title ?? ""
        ImageManager.share.fetchImage(with: movie.posterPath ?? "") { image in
            DispatchQueue.main.async { [weak self] in
                guard let `self` = self else {return}
                self.imageMovie.image = image
            }
        }
    }
}
