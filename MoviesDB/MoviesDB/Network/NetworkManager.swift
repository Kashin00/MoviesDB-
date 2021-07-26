//
//  NetworkManager.swift
//  MoviesDB
//
//  Created by admin on 20.07.2021.
//

import Foundation
import UIKit

enum ApiType {
    
    case upcoming
    case topRated
    case popular
    case random
    case poster
    case search
    
    var apiKey: String {
        return "?api_key=a19c5b2987101c209439576411e5c98f"
    }
    
    var baseAPIURL: String {
        return "https://api.themoviedb.org/3/"
    }
    var basePosterURL: String {
        return "https://image.tmdb.org/t/p/w500"
    }
   
    var path: String {
        switch self {
        case .upcoming: return "movie/upcoming" + apiKey 
        case .topRated: return "movie/top_rated" + apiKey
        case .popular: return "movie/popular" + apiKey
        case .random: return  "trending/movie/week" + apiKey
        case .poster: return basePosterURL
        case .search: return  baseAPIURL + "search/movie" + apiKey + "&query="
        }
    }
    
    var request: URLRequest {
        let baseURL = URL(string: baseAPIURL)!
        let url = URL(string: path, relativeTo: baseURL)!
        let request = URLRequest(url: url)
        
        return request
    }
}

class NetworkManager {
    
    static let shared = NetworkManager()
    private init() {}
    
    private let session = URLSession.shared
    
    func fetchPopularFilms (onCompletion: @escaping ([Movie]) -> ()) {
        let request = ApiType.popular.request
        
        session.dataTask(with: request) { (data, responce, error) in
            guard  let data = data else { return print(error!) }

            do {
                let movieData = try JSONDecoder().decode(MovieResponce.self, from: data)
                onCompletion(movieData.movies)
            } catch {
                print(error)
            }
        }.resume()
    }
    
    func fetchTopRatedFilms (onCompletion: @escaping ([Movie]) -> ()) {
        let request = ApiType.topRated.request
        
        session.dataTask(with: request) { (data, responce, error) in
            guard let data = data else { return print(error!) }

            do {
                let movieData = try JSONDecoder().decode(MovieResponce.self, from: data)
                onCompletion(movieData.movies)
            } catch {
                print(error)
            }
        }.resume()
    }
    
    func fetchUpcomingFilms (onCompletion: @escaping ([Movie]) -> ()) {
        let request = ApiType.upcoming.request
        
        session.dataTask(with: request) { (data, responce, error) in
            guard let data = data else { return print(error!) }

            do {
                let movieData = try JSONDecoder().decode(MovieResponce.self, from: data)
                onCompletion(movieData.movies)
            } catch {
                print(error)
            }
        }.resume()
    }
    
    func getRandomFilms (onCompletion: @escaping ([Movie]) -> ()) {
        let request = ApiType.random.request
        
        session.dataTask(with: request) { (data, responce, error) in
            guard let data = data else { return print(error!) }
            do {
                let movieData = try JSONDecoder().decode(MovieResponce.self, from: data)
                onCompletion(movieData.movies)
            } catch {
                print(error)
            }
        }.resume()
    }
    
    func getSearchResults (searchTerm: String, onCompletion: @escaping ([Movie]) -> ()) {
        
        let endUrl = searchTerm.components(separatedBy: " ").filter { !$0.isEmpty }.joined(separator: "%20")
        
        guard let url = URL(string: ApiType.search.path + endUrl) else { return }
        
        let request = URLRequest(url: url)
        
        session.dataTask(with: request) { (data, responce, error) in
            guard let data = data else { return print(error!) }

            do {
                let movieData = try JSONDecoder().decode( MovieResponce.self, from: data)
                onCompletion(movieData.movies)
            } catch {
                print(error)
            }
        }.resume()
    }
    
    func getImageURL(posterPath: String) -> URL {
        
        guard let url = URL(string: ApiType.poster.path + posterPath) else { return URL(string: "")! }
        return url
        
    }
}


