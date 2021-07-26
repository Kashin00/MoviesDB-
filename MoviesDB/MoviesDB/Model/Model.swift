//
//  Model.swift
//  MoviesDB
//
//  Created by admin on 20.07.2021.
//

import Foundation
import UIKit

// MARK: - Welcome
struct MovieResponce: Decodable {
    let page: Int
    let movies: [Movie]
    let totalResults, totalPages: Int
   
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
    }
}
// MARK: - Result
struct Movie: Decodable, Hashable, Equatable {
    let posterPath: String?
    let overview: String
    let releaseDate: String?
    let genreIDS: [Int]
    let id: Int
    let title: String
    let popularity: Double
    let voteCount: Int
    let voteAverage: Double
    var ganre : [String]
    var image = UIImage(named: "unknown")

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

        var newGanre = [String]()
        let ganreAllIDS = genreIDS
        ganreAllIDS.forEach { (ganreId: Int) in
            Genre.ganresArray.forEach{ if $0.id == ganreId {
                newGanre.append($0.name)
            }
            } }
        ganre = newGanre
        
    }
}
// MARK: - Genre
struct Genre: Codable {
    let id: Int
    let name: String

static let ganresArray: [Genre] = [Genre (id: 28, name: "Action"),
                            Genre (id: 12, name: "Adventure"),
                            Genre (id: 16, name: "Animation"),
                            Genre (id: 35, name: "Comedy"),
                            Genre (id: 80, name: "Crime"),
                            Genre (id: 99, name: "Documentary"),
                            Genre (id: 18, name: "Drama"),
                            Genre (id: 10751, name: "Family"),
                            Genre (id: 14, name: "Fantasy"),
                            Genre (id: 36, name: "History"),
                            Genre (id: 27, name: "Horror"),
                            Genre (id: 10402, name: "Music"),
                            Genre (id: 9648, name: "Mystery"),
                            Genre (id: 10749, name: "Romance"),
                            Genre (id: 878, name: "Science Fiction"),
                            Genre (id: 10770, name: "TV Movie"),
                            Genre (id: 53, name: "Thriller"),
                            Genre (id: 10752, name: "War"),
                            Genre (id: 37, name: "Western")]
}
