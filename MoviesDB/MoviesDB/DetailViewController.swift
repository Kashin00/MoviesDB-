//
//  DetailViewController.swift
//  MoviesDB
//
//  Created by Матвей Кашин on 20.07.2021.
//

import UIKit
import SDWebImage

class DetailViewController: UIViewController {

    @IBOutlet weak var durationLable: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    
    
    @IBOutlet weak var detailView: DetailView!
    var movie: Movie?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUp()
    }
}

extension DetailViewController {
    
    func setUp() {
        guard let movie = movie else { return }
        detailView.setUpView(movie: movie)
    }
    
    func setUpAllInfo (){
        
        
    }
}
