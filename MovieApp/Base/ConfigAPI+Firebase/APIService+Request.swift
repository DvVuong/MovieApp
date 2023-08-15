//
//  APIService+Request.swift
//  MovieApp
//
//  Created by mr.root on 7/31/23.
//

import Foundation
import RxSwift
import SwiftUI

extension APIService {
    //Get List Movie
   static func fetchListMovie<T: Codable>(with object: T.Type ) -> Observable<T> {
        let path = APIPath.trending
        return fetchModel(with: .get, path: path, parameter: ["":""], expecting: object)
    }
    
    //Get Top Rate Movie
    static func fetchTopRateMovie<T: Codable>(with object: T.Type) -> Observable<T> {
        let path = APIPath.topRate
        return fetchModel(with: .get, path: path, expecting: object)
    }
    
    //Get On The Air
    static func fecthOnTheAir<T: Codable>(with object: T.Type) -> Observable<T> {
        let path = APIPath.onTheAir
        return fetchModel(with: .get, path: path, expecting: object)
    }
    
    //Get TV List
    static func fetchTVList<T: Codable>(with object: T.Type) -> Observable<T> {
        let path = APIPath.tvList
        return fetchModel(with: .get, path: path, expecting: object)
    }
    
    //Get upcoming
    static func fecthUpComingMovie<T: Codable>(with objcet: T.Type) -> Observable<T> {
        let path = APIPath.upComing
        return fetchModel(with: .get, path: path, expecting: objcet)
    }
    
    //Get Favorites Movie
    static func getFavoritesMovie<T: Codable>(with object: T.Type) -> Observable<T> {
        let path = APIPath.favorites
        return fetchModel(path: path, expecting: object)
    }
    
    // Add FavoriteMovie
    static func createFavoriteMovie<T: Codable>(with object: T.Type, movieID: Int? = 0, isFavorite: Bool) -> Observable<T> {
        let path = APIPath.addFavoriteMovie
        let param: [String: Any] = [
            "media_type": "movie",
            "media_id": movieID ?? 0,
            "favorite": isFavorite
        ]
        return requestModel(with: .post, path: path, expecting: object, parameter: param)
    }
    
    //Get Video
    static func fetchVideo<T: Codable>(with object: T.Type, movieId: Int) -> Observable<T> {
        let path = APIPath.videos +  "\(movieId)" + "/" + "videos"
        return fetchModel(path: path, expecting: object)
    }
    //Search Movie or TV
    static func searchMovieTV<T: Codable>(with object: T.Type, type: String, text: String, page: Int) -> Observable<T> {
        let path = "search/" + type + "?query="  + text + APIPath.defaultValue + "\(page)"
        return fetchModel(path: path, expecting: object)
    }
    
    //Get listMovie WatchChing now
    
    static func getwatchChingNowMovie<T: Codable>(with object: T.Type, page: Int) -> Observable<T> {
        let path = APIPath.nowPlaying
        let param: [String: Any] = [
            "language" : "en-US",
            "page" : page
        ]
        
        return fetchModel(with: .get, path: path, parameter: param, expecting: object)
    }
}
