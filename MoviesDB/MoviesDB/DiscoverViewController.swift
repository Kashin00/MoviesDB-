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
        setSharedMovieButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setUpDiscoverViewController()
    }
    
    @IBAction func tapNextFilmButton(_ sender: UIButton) {
        setUpDiscoverViewController()
    }
    
    @IBAction func tapAddToFavoriteBurron(_ sender: UIButton) {
        guard let movie = movie else { return }
        if !UserDefaultsManager.shared.titles.contains(movie.title) {
            sender.isSelected = true
            MovieManager.shared.favoriteMovies.append(movie)
            UserDefaultsManager.shared.archivedData()
        } else {
            sender.isSelected = false
            guard let index = MovieManager.shared.favoriteMovies.firstIndex(where: {$0.title == movie.title}) else { return }
            MovieManager.shared.favoriteMovies.remove(at: index)
            UserDefaultsManager.shared.archivedData()
        }
    }
}

extension DiscoverViewController {
    func setSharedMovieButton() {
        let boldConfig = UIImage.SymbolConfiguration(weight: .bold)
        let boldSearch = UIImage(systemName: "square.and.arrow.up", withConfiguration: boldConfig)
        
        let sharedMovieButton = UIBarButtonItem(image: boldSearch, style: .plain, target: self, action: #selector(didTapShareMoviesButton))
        
        self.navigationItem.rightBarButtonItem = sharedMovieButton
    }
    
    func setUpDiscoverViewController() {
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
    
    func setStateConfigForAddToFavoriteButton() {
        guard let movie = movie else { return }
        if !UserDefaultsManager.shared.titles.contains(movie.title) {
            addToFavoriteLabel.isSelected = false
        } else {
            addToFavoriteLabel.isSelected = true
        }
    }
    
    @objc func didTapShareMoviesButton(_ sender: UIBarButtonItem) {
        guard let movie = movie else { return }
        
        let item = [NetworkManager.shared.getURLForShare(id: movie.id)]
        let activityController = UIActivityViewController(activityItems: item, applicationActivities: nil)
        self.present(activityController, animated: true, completion: nil)
    }
}
