//
//  NetworkManager.swift
//  MoviesDB
//
//  Created by admin on 20.07.2021.
//

import Foundation

enum ApiType {
    
    case upcoming
    case topRated
    case popular
    
    var apiKey: String {
        return "?a19c5b2987101c209439576411e5c98f"
    }
    
    var baseAPIURL: String {
        return "https://api.themoviedb.org/3/"
    }
    
    var path: String {
        switch self {
        case .upcoming: return "movie/upcoming" + apiKey
        case .topRated: return "movie/top_rated" + apiKey
        case .popular: return "movie/popular" + apiKey
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
            guard let response = responce,
                  let data = data else { return print(error!) }
            print(response)
            do {
                let movieData = try JSONDecoder().decode( [Movie].self, from: data)
                onCompletion(movieData)
            } catch {
                print(error)
            }
        }.resume()
    }
    
    func fetchTopRatedFilms (onCompletion: @escaping ([Movie]) -> ()) {
        let request = ApiType.topRated.request
        
        session.dataTask(with: request) { (data, responce, error) in
            guard let response = responce,
                  let data = data else { return print(error!) }
            print(response)
            do {
                let movieData = try JSONDecoder().decode( [Movie].self, from: data)
                onCompletion(movieData)
            } catch {
                print(error)
            }
        }.resume()
    }
    
    func fetchUpcomingFilms (onCompletion: @escaping ([Movie]) -> ()) {
        let request = ApiType.topRated.request
        
        session.dataTask(with: request) { (data, responce, error) in
            guard let response = responce,
                  let data = data else { return print(error!) }
            print(response)
            do {
                let movieData = try JSONDecoder().decode( [Movie].self, from: data)
                onCompletion(movieData)
            } catch {
                print(error)
            }
        }.resume()
    }
}
