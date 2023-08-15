//
//  HeaderCell.swift
//  MovieApp
//
//  Created by BeeTech on 15/06/2023.
//

import UIKit
import SnapKit

protocol HeaderCellDelegate: AnyObject {
    func didTapFavourite(with isFavorites: Bool, index: Int)
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
         button.addTarget(self, action: #selector(didTapButton(_:)), for: .touchUpInside)
        return button
    }()
    
    private var unFavoriteMovie: UIButton = {
       let button = UIButton()
        button.setTitle("Unlike", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.contentEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        button.isHidden = true
        button.setTitleColor(UIColor.black, for: .normal)
        button.backgroundColor = .systemGray6
        button.addTarget(self, action: #selector(didTapButton(_:)), for: .touchUpInside)
        button.cornerRadius(5)
        return button
    }()
    
    private var titleFavorites: CustomLabel = {
       let lable = CustomLabel()
        lable.text = "Đã Thích"
        lable.textAlignment = .right
        lable.translatesAutoresizingMaskIntoConstraints = false
        lable.textColor = .black
        lable.backgroundColor = .systemGray6
        lable.isHidden = true
        lable.cornerRadiusLabel(5)
        return lable
    }()
    
    public var actionChooseIDMovie: ((Int?) -> Void)? = nil
    public var actionUnFavoriteMovie: ((Int?) -> Void)? = nil
    private var idMovie: Int? = 0
    private var data: Movie?
    var indexItem: Int? = 0
    weak var delegate: HeaderCellDelegate?
    
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
        addSubview(titleFavorites)
        addSubview(unFavoriteMovie)
        
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
        
        unFavoriteMovie.snp.makeConstraints { make in
            make.width.lessThanOrEqualTo(150)
            make.height.equalTo(50)
            make.trailing.equalToSuperview().offset(-50)
            make.bottom.equalTo(imageMovie.snp.bottom).offset(-10)
        }
        
        titleFavorites.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.width.lessThanOrEqualTo(150)
            make.height.equalTo(35)
            make.trailing.equalToSuperview().offset(-5)
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
        self.idMovie = movie.id ?? 0
        if (movie.isFavorites ?? false) == true {
            titleFavorites.isHidden = false
            favouriteButton.isHidden = true
            unFavoriteMovie.isHidden = false
        }
        ImageManager.share.fetchImage(with: movie.posterPath ?? "") { [weak self] image in
            guard let `self` = self else {return}
            DispatchQueue.main.async {
                self.imageMovie.image = image
            }
        }
        
//        let movieUserDefault = UserDefaultManager.shared.getFavoritesMovie()
//        
//        guard movieUserDefault != nil else {return}
//        
//        if movieUserDefault?.isFavorites == true {
//            titleFavorites.isHidden = false
//        }
    }
    
    //MARK: - ActionButton
    @objc private func didTapButton(_ sender: UIButton) {
        let movie = Movie(backdropPath: data?.backdropPath,
                          id: data?.id,
                          title: data?.title,
                          originalLanguage: data?.originalLanguage,
                          originalTitle: data?.originalTitle,
                          overview: data?.overview,
                          posterPath: data?.posterPath,
                          mediaType: data?.mediaType,
                          releaseDate: data?.releaseDate,
                          voteAverage: data?.voteAverage,
                          isFavorites: true)
        if sender === favouriteButton {
            UserDefaultManager.shared.favoritesMovie = movie
            actionChooseIDMovie?(idMovie)
            delegate?.didTapFavourite(with: true, index: indexItem ?? 0)
        }else if sender === unFavoriteMovie {
            titleFavorites.isHidden = true
            unFavoriteMovie.isHidden = true
            favouriteButton.isHidden = false
            actionUnFavoriteMovie?(idMovie)
        }
    }
}
