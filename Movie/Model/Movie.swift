//
//  Movie.swift
//  Movie
//
//  Created by Thibault Ballof on 21/04/2024.
//

import Foundation

struct MoviesResults: Decodable {
    let results: [Movie]
}

// MARK: - Result
struct Movie: Decodable {
    let backdropPath: String
    let title: String
    let posterPath: String
    let releaseDate: String
    let overview: String

    enum CodingKeys: String, CodingKey {
        case title, overview
        case backdropPath = "backdrop_path"
        case posterPath = "poster_path"
        case releaseDate = "release_date"
    }
}
