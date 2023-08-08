//
//  VideosResponse.swift
//  MovieApp
//
//  Created by mr.root on 8/7/23.
//

import Foundation

struct VideosResponse: Codable {
    var id: Int?
    var results: [Video]?
    private enum CodingKeys: String, CodingKey {
        case id
        case results
    }
}

struct Video: Codable {
    var name: String?
    var key: String?
    var site: String?
    var type: String?
    var id: String?
    private enum CodingKeys: String, CodingKey {
        case name
        case key
        case site
        case type
        case id
    }
}
