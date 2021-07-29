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
    @IBOutlet weak var originalLabel: UILabel!
    @IBOutlet weak var addToFavoriteButton: UIButton!
    
    
    @IBOutlet weak var detailView: DetailView!
    
    var movie: Movie?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setSharedMovieButton()
        setUp()
        setUpAdditionalInfo()
    }
    
    
    @IBAction func didTapAddToFavoriteVCButton(_ sender: UIButton) {
        sender.isSelected = true
        guard let movie = movie else { return }
        if !UserDefaultsManager.shared.titles.contains(movie.title) {
            MovieManager.shared.favoriteMovies.append(movie)
            UserDefaultsManager.shared.archivedData()
        } else {
            self.alertForAddToFavorite()
        }
    }
    
    @objc func didTapShareMoviesButton(_ sender: UIBarButtonItem) {
        guard let movie = movie else { return }
       
        let item = [NetworkManager.shared.getURLForShare(id: movie.id)]
        let activityController = UIActivityViewController(activityItems: item, applicationActivities: nil)
        self.present(activityController, animated: true, completion: nil)
      }
}

extension DetailViewController {
    
    func setSharedMovieButton() {
        let boldConfig = UIImage.SymbolConfiguration(weight: .bold)
        let boldSearch = UIImage(systemName: "square.and.arrow.up", withConfiguration: boldConfig)
        
        let sharedMovieButton = UIBarButtonItem(image: boldSearch, style: .plain, target: self, action: #selector(didTapShareMoviesButton))
        
        self.navigationItem.rightBarButtonItem = sharedMovieButton
    }
    
    func setUp() {
        guard let movie = movie else { return }
        detailView.setUpView(movie: movie)
    }
    
    func setUpAdditionalInfo () {
        guard let movie = movie else { return }
        releaseDateLabel.text = String(movie.releaseDate ?? "")
        ratedLabel.text = String(movie.voteAverage)
        popularityLabel.text = String(Int( movie.popularity))
        originalLabel.text = String(movie.voteCount)
        ganreLabel.text = movie.ganre.joined(separator: ", ")
    }
    
    func alertForAddToFavorite() {
        let alert = UIAlertController(title: UserMessages.alreadyAdded, message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: UserMessages.ok, style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
