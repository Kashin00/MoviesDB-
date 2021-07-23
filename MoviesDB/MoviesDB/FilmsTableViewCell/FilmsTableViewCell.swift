//
//  FilmsTableViewCell.swift
//  MoviesDB
//
//  Created by Матвей Кашин on 20.07.2021.
//

import UIKit

class FilmsTableViewCell: UITableViewCell {

    @IBOutlet weak private var nameLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak private var posterImageView: UIImageView!
    
    public func setUpUI(model: Movie) {
        
//        NetworkManager.shared.getPosterImage(posterPath: (model.posterPath) ?? "0") { (image) in
//            self.posterImageView.image = image
//        }
//
//        nameLabel.text = model.title
//        infoTextView.text = model.overview
        //posterImageView.image =
    }
    
}
