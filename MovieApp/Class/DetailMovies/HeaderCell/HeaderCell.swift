//
//  HeaderCell.swift
//  MovieApp
//
//  Created by BeeTech on 15/06/2023.
//

import UIKit

class HeaderCell: UICollectionReusableView {
    public var actionSeeAll: (() -> Void)? = nil
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    @IBAction func seeAllButton(_ sender: Any) {
        actionSeeAll?()
    }
    
    
}
