//
//  HomeViewController.swift
//  MoviesDB
//
//  Created by Матвей Кашин on 20.07.2021.
//

import UIKit

class HomeViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NetworkManager.shared.fetchTopRatedFilms()
        print(arrayResult.count)
        // Do any additional setup after loading the view.
    }
}

