//
//  DescribeViewController.swift
//  MoviesDB
//
//  Created by Матвей Кашин on 20.07.2021.
//

import UIKit
import SDWebImage

class DiscoverViewController: UIViewController {
    
    @IBOutlet weak var detailView: DetailView!
    
    var movie: Movie?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        movie = MovieManager.shared.randomMovies.shuffled()[0]
        guard let movie = movie else { return }
        
        detailView.setUpView(movie: movie)
        
    }
    @IBAction func tapNextFilmButton(_ sender: UIButton) {
        movie = MovieManager.shared.randomMovies.shuffled()[0]
        guard let movie = movie else { return }
        
        detailView.setUpView(movie: movie)
    }
   
    @IBAction func tapAddToFavoriteBurron(_ sender: UIButton) {
        guard let movie = movie else { return }

        if !MovieManager.shared.favoriteMovies.contains(movie) {
            MovieManager.shared.favoriteMovies.append(movie)
        }
    }
}
