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

    enum MovieApiResponceCodingKeys: String, CodingKey {
        case page
        case movies =  "results"
        case totalResults = "total_results"
        case totalPages = "total_pages"
    }
    
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: MovieApiResponceCodingKeys.self)
//        movies = try container.decode([Movie].self, forKey: .movies)
//        page = try container.decode(Int.self, forKey: .page)
//        totalResults = try container.decode(Int.self, forKey: .totalResults)
//        totalPages = try container.decode(Int.self, forKey: .totalPages)
//    }
}


// MARK: - Result
struct Movie: Decodable {
    let posterPath: String
    let overview, releaseDate: String
    let genreIDS: [Int]
    let id: Int
    let originalTitle: String
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
    
//    init(from decoder: Decoder) throws {
//            let movieContainer = try decoder.container(keyedBy: CodingKeys.self)
//        posterPath = try movieContainer.decode(String.self, forKey: .posterPath)
//        title = try movieContainer.decode(String.self, forKey: .title)
//        popularity = try movieContainer.decode(Double.self, forKey: .popularity)
//        }
}

//enum OriginalLanguage: String, Codable {
//    case en = "en"
//    case fr = "fr"
//}
//// MARK: - Welcome
//struct Welcome: Codable {
//    let adult: Bool
//    let backdropPath: String
//    let belongsToCollection: JSONNull?
//    let budget: Int
//    let genres: [Genre]
//    let homepage: String
//    let id: Int
//    let imdbID, originalLanguage, originalTitle, overview: String
//    let popularity: Double
//    let posterPath: JSONNull?
//    let productionCompanies: [ProductionCompany]
//    let productionCountries: [ProductionCountry]
//    let releaseDate: String
//    let revenue, runtime: Int
//    let spokenLanguages: [SpokenLanguage]
//    let status, tagline, title: String
//    let video: Bool
//    let voteAverage: Double
//    let voteCount: Int
//
//    enum CodingKeys: String, CodingKey {
//        case adult
//        case backdropPath = "backdrop_path"
//        case belongsToCollection = "belongs_to_collection"
//        case budget, genres, homepage, id
//        case imdbID = "imdb_id"
//        case originalLanguage = "original_language"
//        case originalTitle = "original_title"
//        case overview, popularity
//        case posterPath = "poster_path"
//        case productionCompanies = "production_companies"
//        case productionCountries = "production_countries"
//        case releaseDate = "release_date"
//        case revenue, runtime
//        case spokenLanguages = "spoken_languages"
//        case status, tagline, title, video
//        case voteAverage = "vote_average"
//        case voteCount = "vote_count"
//    }
//}

//// MARK: - Genre
//struct Genre: Codable {
//    let id: Int
//    let name: String
//}

//// MARK: - ProductionCompany
//struct ProductionCompany: Codable {
//    let id: Int
//    let logoPath: String?
//    let name, originCountry: String
//
//    enum CodingKeys: String, CodingKey {
//        case id
//        case logoPath = "logo_path"
//        case name
//        case originCountry = "origin_country"
//    }
//}

//// MARK: - ProductionCountry
//struct ProductionCountry: Codable {
//    let iso3166_1, name: String
//
//    enum CodingKeys: String, CodingKey {
//        case iso3166_1 = "iso_3166_1"
//        case name
//    }
//}

//// MARK: - SpokenLanguage
//struct SpokenLanguage: Codable {
//    let iso639_1, name: String
//
//    enum CodingKeys: String, CodingKey {
//        case iso639_1 = "iso_639_1"
//        case name
//    }
//}

//// MARK: - Encode/decode helpers
//
//class JSONNull: Codable, Hashable {
//
//    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
//        return true
//    }
//
//    func hash(into hasher: inout Hasher) {
//
//    }
//
//    public init() {}
//
//    public required init(from decoder: Decoder) throws {
//        let container = try decoder.singleValueContainer()
//        if !container.decodeNil() {
//            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
//        }
//    }
//
//    public func encode(to encoder: Encoder) throws {
//        var container = encoder.singleValueContainer()
//        try container.encodeNil()
//    }
//}
