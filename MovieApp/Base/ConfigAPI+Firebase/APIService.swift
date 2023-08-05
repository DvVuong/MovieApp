//
//  APIService.swift
//  MovieApp
//
//  Created by mr.root on 7/23/23.
//

import Foundation
import RxSwift
import RxRelay
import SwiftUI


enum MethodHTTP: String {
    case get = "GET"
    case post = "POST"
    case deleted = "DELETED"
}

enum CustomError: Error {
    case invalidURL
    case badRequest
}

//typealias APIServiceHandler = (Error?, JSON?) -> Void
class APIService {
    static var shared = APIService()
    static var schedulerBackground: SerialDispatchQueueScheduler = SerialDispatchQueueScheduler(qos: DispatchQoS.userInitiated)
    static var queue = DispatchQueue(label: "CallAPI", qos: .background)
    static var defaultHeader: [String: String] = [
        "accept": "application.json",
        "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI0ZTRlZjlhNThjYmI5OTRhZjNlOGIwOTViMWQ1MDM2YSIsInN1YiI6IjYzMDYwM2Y3NmU5MzhhMDA5MjM2ZTg4NyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.1RUPiu6hjnsCH5_MGlk6xMk1deD7rrUunKMDA19wSeE"
    ]
    
   static func fetchModel<T: Codable>(with method: MethodHTTP = .get,
                               path: String,
                               parameter: [String: Any],
                               expecting: T.Type)  -> Observable<T> {
        return Observable.create { observer in
//            var path = APIPath.shared.BASER_URL
//            let param: [String: String] = [
//                "q": parameter
//            ]
//            var paraString = ""
//            for (key, value) in param {
//                paraString += key + "=" + value
//            }
//
//            if !paraString.isEmpty {
//                paraString = "?" + paraString
//                if (paraString.hasPrefix("&")) {
//                    paraString.removeLast()
//                }
//                path = path + paraString
//            }
            
            var request = URLRequest(url: NSURL(string: APIPath.BASER_URL + "/" + path )! as URL, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
            request.httpMethod = method.rawValue
            request.allHTTPHeaderFields = self.defaultHeader
            let session = URLSession.shared
            let dataTask = session.dataTask(with: request) { data, httpReponse, error in
                guard let data = data, error == nil else {
                    return observer.onError(error!)
                }
                guard let response = httpReponse as? HTTPURLResponse else  {
                    return
                }
                
                if response.statusCode == 400 {
                    observer.onError(CustomError.badRequest)
                }
                
                do {
                    let decoder = JSONDecoder()
                    let json = try decoder.decode(expecting, from: data)
                    observer.onNext(json)
                }
                catch (let error) {
                    DispatchQueue.main.async {
                        print("vuongdv parse JSON Error", String(describing: error))
                    }
                }
                
                observer.onCompleted()
            }
            dataTask.resume()
            return Disposables.create()
        }
    }
    
    
}
