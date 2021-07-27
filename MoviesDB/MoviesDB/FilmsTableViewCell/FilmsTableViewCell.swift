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
    
    public func setUpUI(model: Movie) {

        nameLabel.text = model.title
        infoLabel.text = model.overview
        let url = NetworkManager.shared.getImageURL(posterPath: model.posterPath ?? "")
        posterImageView.sd_setImage(with: url, placeholderImage: UIImage(named: "unknown"), options: [], context: nil)
    }
}
