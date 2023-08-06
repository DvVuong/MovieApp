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
import AVFoundation


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
        "content-type": "application/json",
        "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI0ZTRlZjlhNThjYmI5OTRhZjNlOGIwOTViMWQ1MDM2YSIsInN1YiI6IjYzMDYwM2Y3NmU5MzhhMDA5MjM2ZTg4NyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.1RUPiu6hjnsCH5_MGlk6xMk1deD7rrUunKMDA19wSeE"
    ]
    
    //MARK: Get model
    
   static func fetchModel<T: Codable>(with method: MethodHTTP = .get,
                               path: String,
                               parameter: [String: Any]? = ["":""],
                               expecting: T.Type)  -> Observable<T> {

        return Observable.create { observer in
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
                
                guard response.statusCode == 200 else  {
                    observer.onError(CustomError.badRequest)
                    print("vuongdv StatusCode \(response.statusCode)")
                    return
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
    
    //MARK: Post Model
    
    static func requestModel<T: Codable>(with method: MethodHTTP = .post,
                             path: String,
                             expecting: T.Type,
                             parameter: [String: Any]) -> Observable<T> {
        var jsonRequest: Data?
        if let params = parameter.jsonData {
            jsonRequest = params
        }
        return Observable.create { observer in
            var request = URLRequest(url: NSURL(string: APIPath.BASER_URL + "/" + path )! as URL, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
            request.httpMethod = method.rawValue
            request.allHTTPHeaderFields = self.defaultHeader
            request.httpBody = jsonRequest
            let session = URLSession.shared
            let dataTask = session.dataTask(with: request) { data, response, error in
                guard let data = data  ,error == nil else {return}
                guard let response = response as? HTTPURLResponse else {return}
                
                guard response.statusCode != 200 || response.statusCode != 201 else  {
                    observer.onError(CustomError.badRequest)
                    print("vuongdv StatusCode \(response.statusCode)")
                    return
                }
               
                do {
                    let decoder = JSONDecoder()
                    let json = try decoder.decode(expecting, from: data)
                    print("vuongdv json: \(json)")
                    observer.onNext(json)
                }
                
                catch (let error) {
                    print("vuongdv decoderError: \(error)")
                    observer.onError(error)
                }
                observer.onCompleted()
            }
            dataTask.resume()
            return Disposables.create()
        }
    }
}
