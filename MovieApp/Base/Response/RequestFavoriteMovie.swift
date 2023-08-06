//
//  RequestFavoriteMovie.swift
//  MovieApp
//
//  Created by mr.root on 8/6/23.
//

import Foundation
struct RequestFavoriteMovie: Codable {
    var success: Bool?
    var status_code: Int?
    var status_message: String?
    
    private enum CodingKeys: String ,CodingKey {
        case success
        case status_code = "status_code"
        case status_message = "status_message"
    }
}
