//
//  MovieRepsonse.swift
//  MovieApp
//
//  Created by mr.root on 7/25/23.
//

import Foundation

struct MovieRespone: Codable {
    var page: Int?
    var results: [Movie]?
    private enum CodingKeys: String, CodingKey {
        case results
        case page
    }
}

struct Movie: Codable {
    var backdropPath: String?
    var id: Int?
    var title: String?
    var originalLanguage: String?
    var originalTitle: String?
    var overview: String?
    var posterPath: String?
    var mediaType: String?
    var releaseDate: String?
    var voteAverage: Float?
    var isFavorites: Bool?

        private enum CodingKeys: String, CodingKey {
            case backdropPath = "backdrop_path"
            case id
            case title
            case originalLanguage = "original_language"
            case originalTitle = "original_title"
            case overview
            case posterPath = "poster_path"
            case mediaType = "media_type"
            case releaseDate = "release_date"
            case voteAverage = "vote_average"
            case isFavorites
        }
}
