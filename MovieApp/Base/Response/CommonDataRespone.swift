//
//  CommonDataRespone.swift
//  MovieApp
//
//  Created by mr.root on 7/24/23.
//

import Foundation

class CommonDataRespone<T: Decodable>: CommonResponse {
    var results: T?
    
    enum CodingKeys: String, CodingKey {
        case code
        case msg
        case results
        
    }
    
    required init(form decoder: Decoder) throws {
        super.init()
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        results = try? container.decodeIfPresent(T.self, forKey: .results)
        msg = try? container.decodeIfPresent(String.self, forKey: .msg)
        code = try? container.decodeIfPresent(Int.self, forKey: .code)
    }
    
}
