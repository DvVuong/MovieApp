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
    static func createFavoriteMovie<T: Codable>(with object: T.Type, movieID: Int? = 0) -> Observable<T> {
        let path = APIPath.addFavoriteMovie
        print("vuongdv path: \(path)")
        let param: [String: Any] = [
            "media_type": "movie",
            "media_id": movieID ?? 0,
            "favorite": true
        ]
        return requestModel(with: .post, path: path, expecting: object, parameter: param)
    }
}
