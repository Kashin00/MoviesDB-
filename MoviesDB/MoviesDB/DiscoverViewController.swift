//
//  DescribeViewController.swift
//  MoviesDB
//
//  Created by Матвей Кашин on 20.07.2021.
//

import UIKit

class DiscoverViewController: UIViewController {
    
    private var popularMoviesArray = [Movie]()
    private var topMovie = [Movie]()
    private var upcoming = [Movie]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NetworkManager.shared.fetchPopularFilms { (moviesArray: [Movie]) in
            self.popularMoviesArray = moviesArray
        }
        print(popularMoviesArray.count)
        
        NetworkManager.shared.fetchTopRatedFilms{(top: [Movie]) in
            self.topMovie = top
            print(self.topMovie.count)
        }
        
        //        NetworkManager.shared.fetchUpcomingFilms{(up: [Movie]) in
        //            self.upcoming = up
        //            print(self.upcoming[0].posterPath)
        //        }
    }
}
