//
//  Constant.swift
//  MovieApp
//
//  Created by mr.root on 7/23/23.
//

import Foundation
class APIPath {
    static var BASER_URL = "https://api.themoviedb.org/3"
    static var BASER_IMAGE_URL = "https://image.tmdb.org/t/p/w500"
    static var trending = "trending/movie/week"
    static var topRate = "tv/top_rated"
    static var onTheAir = "tv/on_the_air"
    static var tvList = "discover/tv"
    static var upComing = "movie/upcoming"
    static var nowPlaying = "movie/now_playing"
    ///14214987 is account ID
    static var addFavoriteMovie = "account/14214987/favorite"
    static var favorites = "account/14214987/favorite/movies"
    static var videos = "movie/"
    static var searchMovie = "search/movie?query="
    static var searchTV = "search/tv?query="
    static var defaultValue = "&include_adult=false&language=en-US&page="

    
}
