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
    
    private var arrayOfFavoriteMovies: [Movie] = MovieManager.shared.favoriteMovies
    private var arrayOfRandomMovies: [Movie] = MovieManager.shared.randomMovies
    
    

   
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        detailView.setUpView(movie: MovieManager.shared.randomMovies.shuffled()[0])
        
    }
    @IBAction func tapNextFilmButton(_ sender: UIButton) {
    }
   
    @IBAction func tapAddToFavoriteBurron(_ sender: UIButton) {
    }
}
