//
//  MovieResponce.swift
//  MoviesDB
//
//  Created by Матвей Кашин on 28.07.2021.
//

import Foundation

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
