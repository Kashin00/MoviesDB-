//
//  FilmsByGenreViewController.swift
//  MoviesDB
//
//  Created by Матвей Кашин on 29.07.2021.
//

import UIKit

class FilmsByGenreViewController: UIViewController {

    @IBOutlet weak private var filmsTableView: UITableView!
    private let cell = String(describing: FilmsTableViewCell.self)
    private let heightForRowAt = CGFloat(100)
    
    var movie: [Movie]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        filmsTableView.register(UINib.init(nibName: cell, bundle: nil), forCellReuseIdentifier: cell)
        filmsTableView.backgroundColor = .black
    }
    
    func alertForAddToFavorite() {
        let alert = UIAlertController(title: UserMessages.alreadyAdded, message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: UserMessages.ok, style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func addedToFavorite() {
        let alert = UIAlertController(title: UserMessages.added, message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: UserMessages.ok, style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

extension FilmsByGenreViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return heightForRowAt
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        filmsTableView.deselectRow(at: indexPath, animated: true)
        
        guard let detailVC = storyboard?.instantiateViewController(withIdentifier: String(describing: DetailViewController.self)) as? DetailViewController else {return}

        guard let movie = movie else { return }
        detailVC.movie = movie[indexPath.row]
  
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let addToFavorite = UIContextualAction(style: .normal, title: "❤️") { (action, view, complitionHandler) in
           
            guard let movie = self.movie else { return }
                if !UserDefaultsManager.shared.titles.contains(movie[indexPath.row].title) {
                    MovieManager.shared.favoriteMovies.append(MovieManager.shared.popularMovies[indexPath.row])
                    UserDefaultsManager.shared.archivedData()
                    self.addedToFavorite()
                } else {
                    self.alertForAddToFavorite()
                }
 
            complitionHandler(true)
        }
        let swipe = UISwipeActionsConfiguration(actions: [addToFavorite])
        return swipe
    }
}

extension FilmsByGenreViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movie?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cell, for: indexPath) as? FilmsTableViewCell else {
    return UITableViewCell() }
        
        if let movie = movie {
            let currentElement = movie[indexPath.row]
            cell.setUpUI(model: currentElement)
        }
        return cell
    }
}
