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
final class Movie: NSObject, Decodable, NSCoding {
    
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
    let originalLanguage: String?
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
        case originalLanguage = "original_language"
        case ganre
        case image
    }
    
    init(from decoder: Decoder) throws {
        let movieContainer = try decoder.container(keyedBy: CodingKeys.self)
        posterPath = try? movieContainer.decode(String.self, forKey: .posterPath)
        overview = try movieContainer.decode(String.self, forKey: .overview)
        releaseDate = try? movieContainer.decode(String.self, forKey: .releaseDate)
        genreIDS = try movieContainer.decode([Int].self, forKey: .genreIDS)
        id = try movieContainer.decode(Int.self, forKey: .id)
        title = try movieContainer.decode(String.self, forKey: .title)
        popularity = try movieContainer.decode(Double.self, forKey: .popularity)
        voteCount = try movieContainer.decode(Int.self, forKey: .voteCount)
        voteAverage = try movieContainer.decode(Double.self, forKey: .voteAverage)
        originalLanguage = try? movieContainer.decode(String.self, forKey: .originalLanguage)
        
        var newGanre = [String]()
        let ganreAllIDS = genreIDS
        ganreAllIDS.forEach { (ganreId: Int) in
            Genre.ganresArray.forEach{ if $0.id == ganreId {
                newGanre.append($0.name)
            }
            }
        }
        ganre = newGanre

    }
    
    func encode(with coder: NSCoder) {
        coder.encode(posterPath, forKey: CodingKeys.posterPath.rawValue)
        coder.encode(overview, forKey: CodingKeys.overview.rawValue)
        coder.encode(releaseDate, forKey: CodingKeys.releaseDate.rawValue)
        coder.encode(genreIDS, forKey: CodingKeys.genreIDS.rawValue)
        coder.encode(id, forKey: CodingKeys.id.rawValue)
        coder.encode(title, forKey: CodingKeys.title.rawValue)
        coder.encode(popularity, forKey: CodingKeys.popularity.rawValue)
        coder.encode(voteCount, forKey: CodingKeys.voteCount.rawValue)
        coder.encode(voteAverage, forKey: CodingKeys.voteAverage.rawValue)
        coder.encode(ganre, forKey: CodingKeys.ganre.rawValue)
        coder.encode(image, forKey: CodingKeys.image.rawValue)
    }
    
    init?(coder: NSCoder) {
        posterPath = coder.decodeObject(forKey: CodingKeys.posterPath.rawValue) as? String
        overview = coder.decodeObject(forKey: CodingKeys.overview.rawValue) as? String ?? ""
        releaseDate = coder.decodeObject(forKey: CodingKeys.releaseDate.rawValue) as? String
        genreIDS = coder.decodeObject(forKey: CodingKeys.genreIDS.rawValue) as? [Int] ?? []
        id = coder.decodeObject(forKey: CodingKeys.id.rawValue) as? Int ?? 0
        title = coder.decodeObject(forKey: CodingKeys.title.rawValue) as? String ?? ""
        popularity = coder.decodeObject(forKey: CodingKeys.popularity.rawValue) as? Double ?? 0.0
        voteCount = coder.decodeObject(forKey: CodingKeys.voteCount.rawValue) as? Int ?? 0
        voteAverage = coder.decodeObject(forKey: CodingKeys.voteAverage.rawValue) as? Double ?? 0.0
        ganre = coder.decodeObject(forKey: CodingKeys.ganre.rawValue) as? [String] ?? []
        image = coder.decodeObject(forKey: CodingKeys.image.rawValue) as? UIImage
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

