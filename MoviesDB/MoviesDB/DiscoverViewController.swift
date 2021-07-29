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
    
    @IBOutlet weak var addToFavoriteLabel: UIButton!
    var movie: Movie?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if MovieManager.shared.randomMovies.isEmpty {
            detailView.setUpForNoMovies()
        } else {
        let movies = MovieManager.shared.randomMovies
        let randomizeMovies = movies.shuffled()
        movie = randomizeMovies[0]
        setStateConfigForAddToFavoriteButton()
        guard let movie = movie else { return }
        detailView.setUpView(movie: movie)
        }
    }
    
    @IBAction func tapNextFilmButton(_ sender: UIButton) {
        if MovieManager.shared.randomMovies.isEmpty {
            detailView.setUpForNoMovies()
        } else {
        let movies = MovieManager.shared.randomMovies
        let randomizeMovies = movies.shuffled()
        movie = randomizeMovies[0]
        setStateConfigForAddToFavoriteButton()
        guard let movie = movie else { return }
        detailView.setUpView(movie: movie)
        }
    }
   
    @IBAction func tapAddToFavoriteBurron(_ sender: UIButton) {
        guard let movie = movie else { return }
        if !UserDefaultsManager.shared.titles.contains(movie.title) {
            MovieManager.shared.favoriteMovies.append(movie)
            UserDefaultsManager.shared.archivedData()
            sender.isSelected = true
        }else {
            self.alertForAddToFavorite()
        }
    }
    
    func alertForAddToFavorite() {
        let alert = UIAlertController(title: UserMessages.alreadyAdded, message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: UserMessages.ok, style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func setStateConfigForAddToFavoriteButton() {
        guard let movie = movie else { return }
        if !UserDefaultsManager.shared.titles.contains(movie.title) {
            addToFavoriteLabel.isSelected = false
        } else {
            addToFavoriteLabel.isSelected = true
}
}
}
