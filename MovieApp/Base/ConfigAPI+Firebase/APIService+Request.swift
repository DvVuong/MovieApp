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
        return fetchModel(with: .get, path: path, parameter: ["":""], expecting: object)
    }
    
    //Get On The Air
    static func fecthOnTheAir<T: Codable>(with object: T.Type) -> Observable<T> {
        let path = APIPath.onTheAir
        let params = ["":""]
        return fetchModel(with: .get, path: path, parameter: params, expecting: object)
    }
    
    //Get TV List
    static func fetchTVList<T: Codable>(with object: T.Type) -> Observable<T> {
        let path = APIPath.tvList
        let params = ["":""]
        return fetchModel(with: .get, path: path, parameter: params, expecting: object)
    }
    
    //Get upcoming
    static func fecthUpComingMovie<T: Codable>(with objcet: T.Type) -> Observable<T> {
        let path = APIPath.upComing
        let params = ["":""]
        return fetchModel(with: .get, path: path, parameter: params, expecting: objcet)
    }
}
