//
//  FavoritesMovie.swift
//  MovieApp
//
//  Created by mr.root on 8/6/23.
//

import Foundation

struct FavoritesMovie {
    var d: [Favorites]
}

struct Favorites {
    var movie: [Movie]?
    var favorites: Bool?
}
