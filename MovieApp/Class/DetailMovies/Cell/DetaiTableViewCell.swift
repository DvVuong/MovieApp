//
//  DetaiTableViewCell.swift
//  MovieApp
//
//  Created by mr.root on 8/4/23.
//

import Foundation
import UIKit
import SnapKit

class DetailMovieTableViewCell: UITableViewCell {
    static var indentifier = "DetailMovieTableViewCell"
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
