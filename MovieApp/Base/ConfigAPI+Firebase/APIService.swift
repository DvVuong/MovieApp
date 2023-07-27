//
//  APIService.swift
//  MovieApp
//
//  Created by mr.root on 7/23/23.
//

import Foundation
import RxSwift
import RxRelay


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
    var queue = DispatchQueue(label: "CallAPI", qos: .background)
    private var defaultHeader: [String: String] = [
        "X-RapidAPI-Key": "2937700a51msh8792f64b6a85189p1ed388jsn0d294a68bbb6",
        "X-RapidAPI-Host": "online-movie-database.p.rapidapi.com",
        "content-type": "application/json"
    ]
    
    func fecthListMovie(with method: MethodHTTP = .get, parameter: String)  -> Single<MovieRespone> {
        return Single.create { single in
            var path = APIPath.shared.BASER_URL
            let param: [String: String] = [
                "q": parameter
            ]
            var paraString = ""
            for (key, value) in param {
                paraString += key + "=" + value
            }
            
            if !paraString.isEmpty {
                paraString = "?" + paraString
                if (paraString.hasPrefix("&")) {
                    paraString.removeLast()
                }
                path = path + paraString
            }
            
            var request = URLRequest(url: NSURL(string: path)! as URL, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
            request.httpMethod = method.rawValue
            request.allHTTPHeaderFields = self.defaultHeader
            let session = URLSession.shared
            let dataTask = session.dataTask(with: request) { data, httpReponse, error in
                guard let data = data, error == nil else {
                    return single(.failure(CustomError.invalidURL))
                }
                guard let response = httpReponse as? HTTPURLResponse else  {
                    return
                }
                
                if response.statusCode == 400 {
                    single(.failure(CustomError.badRequest))
                }
                
                do {
                    let decoder = JSONDecoder()
                    let json = try decoder.decode(MovieRespone.self, from: data)
                    single(.success(json))
                }
                catch (let error) {
                    DispatchQueue.main.async {
                        print("vuongdv parse JSON Error", String(describing: error))
                    }
                }
            }
            dataTask.resume()
            return Disposables.create()
        }
    }
}
