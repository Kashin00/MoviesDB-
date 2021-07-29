//
//  MovieManager.swift
//  MoviesDB
//
//  Created by admin on 22.07.2021.
//

import Foundation
import UIKit

final class MovieManager {
    
    static var shared = MovieManager()

    var topRatedMovies = [Movie]()
    var upcommingMovies = [Movie]()
    var popularMovies = [Movie]()
    var randomMovies = [Movie]()
    var favoriteMovies = [Movie]()
    var searchMovies = [Movie]()
    var genreArray = [Movie]()
    
     init() {
        NetworkManager.shared.fetchTopRatedFilms(page: 1){ [self](movie) in
            self.topRatedMovies = movie
        }
        
        NetworkManager.shared.fetchUpcomingFilms(page: 1){ [self](movie) in
            self.upcommingMovies = movie
        }
        
        NetworkManager.shared.fetchPopularFilms(page: 1) { [self](movie) in
            self.popularMovies = movie
        }
        NetworkManager.shared.getRandomFilms{ [self](movie) in
            self.randomMovies = movie
        }
    }
        func loadMorePopularFilms (page: Int) {
            NetworkManager.shared.fetchPopularFilms(page: page) { (movies) in
                self.popularMovies.append(contentsOf: movies)
            }
        }
    
    func loadMoreTopRatedFilms(page: Int) {
        NetworkManager.shared.fetchTopRatedFilms(page: page) { (movies) in
            self.topRatedMovies.append(contentsOf: movies)
        }
    }
    
    func loadMoreUpcomingFilms(page: Int) {
        NetworkManager.shared.fetchUpcomingFilms(page: page) { (movies) in
            self.upcommingMovies.append(contentsOf: movies)
        }
    }
}
