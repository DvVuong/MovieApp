//
//  DetailMovieViewController.swift
//  MovieApp
//
//  Created by BeeTech on 15/06/2023.
//

import UIKit

class DetailMovieViewController: BaseViewController {
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var ageLabel: CustomLabel!
    @IBOutlet weak var escapeButton: UIButton!
    @IBOutlet weak var producerLabel: CustomLabel!
    @IBOutlet weak var categoryLabel: CustomLabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var dataSource: TheCastDataSource = TheCastDataSource()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
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
