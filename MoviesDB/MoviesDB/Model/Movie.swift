//
//  Model.swift
//  MoviesDB
//
//  Created by admin on 20.07.2021.
//

import Foundation
import UIKit

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
        
        var newGanre = [String]()
        let ganreAllIDS = genreIDS
        ganreAllIDS.forEach { (ganreId: Int) in
            Genre.ganresArray.forEach{ if $0.id == ganreId {
                newGanre.append($0.name)
            }
            } }
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
        id = coder.decodeInteger(forKey: CodingKeys.id.rawValue)
        title = coder.decodeObject(forKey: CodingKeys.title.rawValue) as? String ?? ""
        popularity = coder.decodeDouble(forKey: CodingKeys.popularity.rawValue)
        voteCount = coder.decodeInteger(forKey: CodingKeys.voteCount.rawValue)
        voteAverage = coder.decodeDouble(forKey: CodingKeys.voteAverage.rawValue)
        ganre = coder.decodeObject(forKey: CodingKeys.ganre.rawValue) as? [String] ?? []
        image = coder.decodeObject(forKey: CodingKeys.image.rawValue) as? UIImage
    }
}

