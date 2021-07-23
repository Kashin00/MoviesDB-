//
//  MovieManager.swift
//  MoviesDB
//
//  Created by admin on 22.07.2021.
//

import Foundation

class MovieManager {
    
    static var shared = MovieManager()

    var topRatedMovies = [Movie]()
    var upcommingMovies = [Movie]()
    var popularMovies = [Movie]()
    var randomMovies = [Movie]()
    var favoriteMovies = [Movie]()
    var searchArray = [Movie]()
    
    private init() {
        NetworkManager.shared.fetchTopRatedFilms{ [self](movie) in
            self.topRatedMovies = movie
        }
        
        NetworkManager.shared.fetchUpcomingFilms{ [self](movie) in
            self.upcommingMovies = movie
        }
        
        NetworkManager.shared.fetchPopularFilms{ [self](movie) in
            self.popularMovies = movie
        }
        NetworkManager.shared.getRandomFilms{ [self](movie) in
            self.randomMovies = movie
        }
    }
    
    func search (searchWord: String) {
        NetworkManager.shared.getSearchResults(searchTerm: searchWord) { [self] (movies) in
            self.searchArray = movies }
        }
}
