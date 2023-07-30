//
//  MovieRepsonse.swift
//  MovieApp
//
//  Created by mr.root on 7/25/23.
//

import Foundation

struct MovieRespone: Codable {
    var d: [Movie]?
    private enum CodingKeys: String, CodingKey {
        case d
    }
}

struct Movie: Codable {
    var i: ImageMovie?
    let name: String?
    let q: String?
    let cast : String?
    let year: Int?
        private enum CodingKeys: String, CodingKey {
            case name = "l"
            case q
            case cast = "s"
            case year = "y"
            case i
        }
    
}

struct ImageMovie: Codable {
    var height: Int?
    var imageUrl: String?
    var width: Int?
    private enum CodingKeys: String, CodingKey {
        case height
        case imageUrl
        case width
    }
}

//struct MovieRepsonse: Codable {
//    var l: String
////    var q: String
//    var rank: Int
//    var s: String
//    var y: Int
//
//    private enum CodingKeys: String, CodingKey {
//        case l
//        case rank
//        case s
//        case y
//    }
//}
//
//struct MovieResult: Codable {
//    var d: [MovieRepsonse]
//    var q: String
//    var v: String
//    private enum CodingKeys: String, CodingKey {
//        case d
//        case q
//        case v
//    }
//}
