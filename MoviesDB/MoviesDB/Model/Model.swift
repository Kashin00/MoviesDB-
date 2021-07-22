//
//  Model.swift
//  MoviesDB
//
//  Created by admin on 20.07.2021.
//

import Foundation

// MARK: - Welcome
struct MovieResponce: Decodable {
    let page: Int
    let movies: [Movie]
    let totalResults, totalPages: Int
    //let dates: Dates
 

    enum MovieApiResponceCodingKeys: String, CodingKey {
        case page
        case movies =  "results"
        case totalResults = "total_results"
        case totalPages = "total_pages"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: MovieApiResponceCodingKeys.self)
        movies = try container.decode([Movie].self, forKey: .movies)
        page = try container.decode(Int.self, forKey: .page)
        totalResults = try container.decode(Int.self, forKey: .totalResults)
        totalPages = try container.decode(Int.self, forKey: .totalPages)
        //dates = try container.decode(Dates.self, forKey: .dates)
    }
}
// MARK: - Result
struct Movie: Decodable {
    let posterPath: String
    let overview: String
    let releaseDate: String?
    let genreIDS: [Int]
    let id: Int
    let title: String
    let popularity: Double
    let voteCount: Int
    let voteAverage: Double

    enum CodingKeys: String, CodingKey {
        case posterPath = "poster_path"
        case overview
        case releaseDate = "release_date"
        case genreIDS = "genre_ids"
        case id
        case originalTitle = "original_title"
        case title
        case popularity
        case voteCount = "vote_count"
        case voteAverage = "vote_average"
    }
    
    init(from decoder: Decoder) throws {
        let movieContainer = try decoder.container(keyedBy: CodingKeys.self)
        posterPath = try movieContainer.decode(String.self, forKey: .posterPath)
        overview = try movieContainer.decode(String.self, forKey: .overview)
        releaseDate = try? movieContainer.decode(String.self, forKey: .releaseDate)
        genreIDS = try movieContainer.decode([Int].self, forKey: .genreIDS)
        id = try movieContainer.decode(Int.self, forKey: .id)
        title = try movieContainer.decode(String.self, forKey: .title)
        popularity = try movieContainer.decode(Double.self, forKey: .popularity)
        voteCount = try movieContainer.decode(Int.self, forKey: .voteCount)
        voteAverage = try movieContainer.decode(Double.self, forKey: .voteAverage)
    }
}
// MARK: - Genre
struct Genre: Codable {
    let id: Int
    let name: String
}
//// MARK: - Dates
//struct Dates: Codable {
//    let maximum, minimum: String
//}
