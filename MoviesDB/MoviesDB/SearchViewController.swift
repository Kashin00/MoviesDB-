//
//  SearchViewController.swift
//  MoviesDB
//
//  Created by Матвей Кашин on 26.07.2021.
//

import UIKit

class SearchViewController: UIViewController {
    
    @IBOutlet weak private var searchBar: UISearchBar!
    @IBOutlet weak private var filmsTableView: UITableView!
    private let heightForRow = CGFloat(100)
    private var movieArray = [Movie]()
    private let cell = String(describing: FilmsTableViewCell.self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        filmsTableView.register(UINib.init(nibName: cell, bundle: nil), forCellReuseIdentifier: cell)
        searchBar.delegate = self
        NetworkManager.shared.delegate = self
    }
    func addToFavorite(rowIndexPath indexPath: IndexPath) -> UIContextualAction {
        let addToFavotrite = UIContextualAction(style: .destructive, title: "🤍") { (_, _, _) in
            MovieManager.shared.favoriteMovies.append(self.movieArray[indexPath.row])
        }
        addToFavotrite.backgroundColor = .red
        return addToFavotrite
    }
}

extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return heightForRow
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        filmsTableView.deselectRow(at: indexPath, animated: true)
        guard let detailVC = storyboard?.instantiateViewController(withIdentifier: String(describing: DetailViewController.self)) as? DetailViewController else {return}
        detailVC.movie = movieArray[indexPath.row]
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let addToFavorite = self.addToFavorite(rowIndexPath: indexPath)
        let swipe = UISwipeActionsConfiguration(actions: [addToFavorite])
        return swipe
    }
}

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieArray.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cell, for: indexPath) as? FilmsTableViewCell else {
            return UITableViewCell() }
        
        cell.setUpUI(model: movieArray[indexPath.row])
        return cell
    }
}

extension SearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        
        NetworkManager.shared.getSearchResults(searchTerm: searchBar.text ?? "") { (movies) in
            print(movies.count)
            self.movieArray = movies
            DispatchQueue.main.async {
                self.filmsTableView.reloadData()
            }
        }
    }
}

extension SearchViewController: NetworkManagerDelegate {
    func didFailToMakeResponse() {
        let alert = UIAlertController(title: "There are no films with that name", message: "Please, enter the correct name", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
