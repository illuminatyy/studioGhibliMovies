// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let movie = try? newJSONDecoder().decode(Movie.self, from: jsonData)

import Foundation

// MARK: - MovieElement
struct MovieElement: Codable {
    let id, title, movieDescription, director: String
    let producer, releaseDate, rtScore: String
    let people, species, locations, vehicles: [String]
    let url: String

    enum CodingKeys: String, CodingKey {
        case id, title
        case movieDescription = "description"
        case director, producer
        case releaseDate = "release_date"
        case rtScore = "rt_score"
        case people, species, locations, vehicles, url
    }
}

typealias MovieAPI = [MovieElement]
