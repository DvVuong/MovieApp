//
//  DesciptionTableCell.swift
//  MovieApp
//
//  Created by mr.root on 8/4/23.
//

import Foundation
import SnapKit
import UIKit

class DesciptionTableCell: UITableViewCell {

    static var indentifier = "DesciptionTableCell"
    
    private lazy var contentStackView: UIStackView = {
       let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 2
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var nameStackView: UIStackView = {
       let stackView = UIStackView()
        stackView.axis = .horizontal
        return stackView
    }()
    
    private lazy var overviewStackView: UIStackView = {
       let stackView = UIStackView()
        return stackView
    }()
    
    private lazy var voteMovie: UIStackView = {
       let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 5
        stackView.distribution = .fillProportionally
        return stackView
    }()
    
    private lazy var nameMovieLable: UILabel = {
       let nameMovie = UILabel()
        nameMovie.textColor = .black
        return nameMovie
    }()
    
    private lazy var overViewMovie: UILabel = {
       let lable = UILabel()
        lable.textColor = .black
        lable.numberOfLines = 0
        return lable
    }()
    
    private lazy var voteMovieLable: UILabel = {
       let lable = UILabel()
        lable.textColor = .black
        lable.numberOfLines = 1
        return lable
    }()
    
    private lazy var voteLable: UILabel = {
       let lable = UILabel()
        lable.textColor = .black
        lable.text = "Vote:"
        return lable
    }()
    
    private lazy var starImage: UIImageView = {
       let image = UIImageView()
        image.image = Asset.icons8Star16.image
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        setupContentStackView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentStackView.arrangedSubviews.forEach { subView in
            subView.removeFromSuperview()
        }

        contentStackView.addArrangedSubview(nameStackView)
        contentStackView.addArrangedSubview(voteMovie)
        contentStackView.addArrangedSubview(overviewStackView)
        
        contentView.addSubview(contentStackView)
    
        contentStackView.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(2)
            make.leading.equalTo(contentView).offset(10)
            make.trailing.equalTo(contentView).offset(-10)
            make.bottom.equalTo(contentView).offset(-2)
        }
    }
    
    private func setupContentStackView() {
        overviewStackView.arrangedSubviews.forEach { subView in
            subView.removeFromSuperview()
        }

        nameStackView.arrangedSubviews.forEach { subView in
            subView.removeFromSuperview()
        }
    
        voteMovie.arrangedSubviews.forEach { subView in
            subView.removeFromSuperview()
        }
        
        voteLable.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        voteLable.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        starImage.setContentHuggingPriority(.defaultHigh, for:  .horizontal)
        starImage.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        voteMovieLable.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        voteMovieLable.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        
        nameMovieLable.setContentHuggingPriority(.defaultHigh, for: .vertical)
        nameMovieLable.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        overViewMovie.setContentHuggingPriority(.defaultHigh, for: .vertical)
        overViewMovie.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        
        starImage.snp.makeConstraints { make in
            make.width.height.equalTo(15)
        }
        
        voteLable.snp.makeConstraints { make in
            make.width.lessThanOrEqualTo(45)
        }
        
        voteMovie.addArrangedSubview(voteLable)
        voteMovie.addArrangedSubview(starImage)
        voteMovie.addArrangedSubview(voteMovieLable)
        nameStackView.addArrangedSubview(nameMovieLable)
        overviewStackView.addArrangedSubview(overViewMovie)
    }
    
    func bindData(with data: Movie?) {
        guard let data = data else {return}
        nameMovieLable.text = "Movie: \(data.originalTitle ?? "") "
        overViewMovie.text = "Overview: \(data.overview ?? "") "
        voteMovieLable.text = "\(data.voteAverage ?? 0)"
    }
}
