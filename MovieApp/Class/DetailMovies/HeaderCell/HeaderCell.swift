//
//  HeaderCell.swift
//  MovieApp
//
//  Created by BeeTech on 15/06/2023.
//

import UIKit
import SnapKit

protocol HeaderCellDelegate: AnyObject {
    func didTapPlayButton()
    func didTapFavourite()
}

class HeaderCell: UIView {
    
     lazy var backButton: UIButton = {
       let button = UIButton()
        let image = Asset.icons8BackBlack.image
         button.setImage(image, for: .normal)
         button.translatesAutoresizingMaskIntoConstraints = false
         button.backgroundColor = .systemGray6
         button.conerRadius(with: 5)
        return button
    }()
    
     lazy var imageMovie: UIImageView = {
       let image = UIImageView()
         image.cornerRadius(10)
         image.contentMode = .scaleAspectFill
         image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
     lazy var playButton: UIButton = {
       let button = UIButton()
         button.cornerRadius(5)
         button.setupBoderWidth(with: 1, color: UIColor.white.cgColor)
         button.setTitle("Play", for: .normal)
         button.setTitleColor(UIColor.black, for: .normal)
         button.translatesAutoresizingMaskIntoConstraints = false
         button.backgroundColor = .systemGray6
        return button
    }()
    
     lazy var favouriteButton: UIButton = {
       let button = UIButton()
        button.cornerRadius(5)
        button.setupBoderWidth(with: 1, color: UIColor.white.cgColor)
        let image = UIImage(systemName: "heart.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 15))
        button.setImage(image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemGray6
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        addGradian()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(imageMovie)
        addSubview(playButton)
        addSubview(favouriteButton)
        addSubview(backButton)
        
        imageMovie.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.trailing.equalToSuperview().offset(-5)
            make.leading.equalToSuperview().offset(5)
        }
        
        backButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.width.height.equalTo(30)
            make.leading.equalToSuperview().offset(15)
        }
        
        playButton.snp.makeConstraints { make in
            make.width.equalTo(80)
            make.height.equalTo(50)
            make.leading.equalToSuperview().offset(50)
            make.bottom.equalTo(imageMovie.snp.bottom).offset(-10)
        }
        
        favouriteButton.snp.makeConstraints { make in
            make.width.equalTo(80)
            make.height.equalTo(50)
            make.trailing.equalToSuperview().offset(-50)
            make.bottom.equalTo(imageMovie.snp.bottom).offset(-10)
        }
        updateConstraintsIfNeeded()
    }
    
    private func addGradian() {
        let gradianLayer = CAGradientLayer()
        gradianLayer.colors = [
            UIColor.clear.cgColor,
            UIColor.systemBackground.cgColor
        ]
        gradianLayer.frame = bounds
        layer.addSublayer(gradianLayer)
    }
    
    func bindData(with movie: Movie) {
        ImageManager.share.fetchImage(with: movie.posterPath ?? "") { [weak self] image in
            guard let `self` = self else {return}
            DispatchQueue.main.async {
                self.imageMovie.image = image
            }
        }
    }
}
