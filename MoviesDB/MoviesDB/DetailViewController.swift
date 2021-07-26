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
    @IBOutlet weak var ganreLable: UILabel!
    @IBOutlet weak var popularityLabel: UILabel!
    @IBOutlet weak var originalLabel: UILabel!
    
    
    @IBOutlet weak var detailView: DetailView!
    
    var movie: Movie?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUp()
        
        guard let movie = movie else { return }
        setUpAllInfo(movie: movie)
    }
}

extension DetailViewController {
    
    func setUp() {
        guard let movie = movie else { return }
        detailView.setUpView(movie: movie)
    }
    
    func setUpAllInfo (movie: Movie){
        releaseDateLabel.text = String(movie.releaseDate ?? "")
        ratedLabel.text = String(movie.voteAverage)
        popularityLabel.text = String(Int( movie.popularity))
        originalLabel.text = movie.originalLanguage
//        let movieEnumerated = movie.ganre.enumerated()
        ganreLable.text = movie.ganre.joined(separator: ", ")
        
    }
}
