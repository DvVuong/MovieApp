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
    func fetchListMovie<T: Codable>(with object: T.Type ) -> Observable<T> {
        let path = APIPath.trending
        return fetchData(with: .get, path: path, parameter: ["":""], expecting: object)
    }
    
    //Get Top Rate Movie
    func fetchTopRateMovie<T: Codable>(with object: T.Type) -> Observable<T> {
        let path = APIPath.topRate
        return fetchData(with: .get, path: path, parameter: ["":""], expecting: object)
    }
    
    //Get On The Air
    func fecthOnTheAir<T: Codable>(with object: T.Type) -> Observable<T> {
        let path = APIPath.onTheAir
        let params = ["":""]
        return fetchData(with: .get, path: path, parameter: params, expecting: object)
    }
    
}
