//
//  DetailViewController.swift
//  MoviesDB
//
//  Created by Матвей Кашин on 20.07.2021.
//

import UIKit
import SDWebImage

class DetailViewController: UIViewController {
    
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var ratedLabel: UILabel!
    @IBOutlet weak var ganreLabel: UILabel!
    @IBOutlet weak var popularityLabel: UILabel!
    @IBOutlet weak var peopleAppreciatedLabel: UILabel!
    @IBOutlet weak var addToFavoriteButton: UIButton!
    
    
    @IBOutlet weak var detailView: DetailView!
    
    var movie: Movie?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        setUpAdditionalInfo()
        setSharedMovieButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setStateConfigForAddToFavoriteButton()
    }
    
    @IBAction func didTapAddToFavoriteVCButton(_ sender: UIButton) {
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

extension DetailViewController {
    
    func setUp() {
        guard let movie = movie else { return }
        detailView.setUpView(movie: movie)
    }
    
    func setUpAdditionalInfo () {
        guard let movie = movie else { return }
        releaseDateLabel.text = String(movie.releaseDate ?? "")
        ratedLabel.text = String(movie.voteAverage)
        popularityLabel.text = String(Int( movie.popularity))
        peopleAppreciatedLabel.text = String(movie.voteCount)
        ganreLabel.text = movie.ganre.joined(separator: ", ")
    }
    
    func setStateConfigForAddToFavoriteButton() {
        guard let movie = movie else { return }
        if !UserDefaultsManager.shared.titles.contains(movie.title) {
            addToFavoriteButton.isSelected = false
        } else {
            addToFavoriteButton.isSelected = true
        }
    }
    
    func setSharedMovieButton() {
        let boldConfig = UIImage.SymbolConfiguration(weight: .bold)
        let boldSearch = UIImage(systemName: "square.and.arrow.up", withConfiguration: boldConfig)
        
        let sharedMovieButton = UIBarButtonItem(image: boldSearch, style: .plain, target: self, action: #selector(didTapShareMoviesButton))
        
        self.navigationItem.rightBarButtonItem = sharedMovieButton
    }
    
    @objc func didTapShareMoviesButton(_ sender: UIBarButtonItem) {
        guard let movie = movie else { return }
        
        let item = [NetworkManager.shared.getURLForShare(id: movie.id)]
        let activityController = UIActivityViewController(activityItems: item, applicationActivities: nil)
        self.present(activityController, animated: true, completion: nil)
    }
}
