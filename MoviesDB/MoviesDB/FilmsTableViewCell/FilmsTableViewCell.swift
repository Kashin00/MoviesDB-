//
//  FilmsTableViewCell.swift
//  MoviesDB
//
//  Created by Матвей Кашин on 20.07.2021.
//

import UIKit
import SDWebImage


class FilmsTableViewCell: UITableViewCell {

    @IBOutlet weak private var nameLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak private var posterImageView: UIImageView!
    var imageSender: ((UIImage) -> ())?
    
    public func setUpUI(model: Movie) {
        NetworkManager.shared.getPosterImage(posterPath: model.posterPath ?? "") { (image) in
            self.posterImageView.image = image
            self.imageSender?(image)
        }
        nameLabel.text = model.title
        infoLabel.text = model.overview        
    }
}
