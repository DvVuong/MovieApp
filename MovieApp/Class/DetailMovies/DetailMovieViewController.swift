//
//  DetailMovieViewController.swift
//  MovieApp
//
//  Created by BeeTech on 15/06/2023.
//

import UIKit
import RxSwift

class DetailMovieViewController: BaseViewController {
    
    @IBOutlet weak var imageMovie: UIImageView!
    @IBOutlet weak var nameMovieLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var ageLabel: CustomLabel!
    @IBOutlet weak var escapeButton: UIButton!
    @IBOutlet weak var producerLabel: CustomLabel!
    @IBOutlet weak var categoryLabel: CustomLabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var dataSource: TheCastDataSource = TheCastDataSource()
    private var viewModel: DetailViewModel = DetailViewModel()
    private var bag = DisposeBag()
    convenience init(item: Movie) {
        self.init()
        viewModel.movieItem.onNext(item)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupViewModel()
    }
    
    override func setupViewModel() {
        viewModel.movieItemBehaviorRelay
            .subscribe(onNext: {[weak self] movie in
                print("vuongdv movie: \(movie.name ?? "nil")")
                guard let `self` = self else {return}
                self.nameMovieLabel.text = movie.name
                self.producerLabel.text = movie.q
                self.categoryLabel.text = movie.name
            })
            .disposed(by: bag)
        
        DispatchQueue.main.async {[weak self] in
            guard let `self` = self else {return}
            self.imageMovie.image = self.viewModel.getImage()
        }
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        escapeButton.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi * 0.5))
        ageLabel.cornerRadiusLabel(8)
        producerLabel.cornerRadiusLabel(8)
        categoryLabel.cornerRadiusLabel(8)
        backButton.cornerRadius(5)
        escapeButton.cornerRadius(5)
    }
    
    override func setupTap() {
        backButton.addTarget(self, action: #selector(didTapButton(_:)), for: .touchUpInside)
    }
    
    override func setupUI() {
        collectionView.delegate = dataSource
        collectionView.dataSource = dataSource
        collectionView.register(UINib(nibName: "TheCastCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "TheCastCollectionViewCell")
        collectionView.register(UINib(nibName: "HeaderCell", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "HeaderCell")
    }
    
    //MARK: Action
    
    @objc private func didTapButton(_ sender: UIButton) {
        pop()
    }
}
