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
    private let cell = String(describing: FilmsTableViewCell.self)
    private let pullToRefreshIndicator = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        filmsTableView.register(UINib.init(nibName: cell, bundle: nil), forCellReuseIdentifier: cell)
        searchBar.delegate = self
        NetworkManager.shared.delegate = self
        searchBar.becomeFirstResponder()
        searchBar.searchTextField.textColor = .white
        searchBar.setPlaceholderText(color: .black)
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        pullToRefreshIndicator.tintColor = .white
        pullToRefreshIndicator.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        filmsTableView.addSubview(pullToRefreshIndicator)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: tapBackButton())
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    func alertForAddToFavorite() {
        let alert = UIAlertController(title: UserMessages.alreadyAdded, message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: UserMessages.ok, style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    @objc func refresh(_ sender: AnyObject) {
        
        MovieManager.shared.searchMovies.shuffle()
        
        self.perform(#selector(endRefreshing), with: nil, afterDelay: 1)
    }
    
    @objc func endRefreshing() {
        filmsTableView.reloadData()
        pullToRefreshIndicator.endRefreshing()
    }
    
    func tapBackButton() -> UIButton {
        let config = UIImage.SymbolConfiguration(pointSize: 20.0, weight: .medium, scale: .medium)
        let backButtonImage = UIImage(systemName: "chevron.left", withConfiguration: config)?.withRenderingMode(.alwaysTemplate)
        let backButton = UIButton(type: .custom)
        backButton.setImage(backButtonImage, for: .normal)
        backButton.tintColor = .systemBlue
        backButton.setTitle(" Back", for: .normal)
        backButton.setTitleColor(.systemBlue, for: .normal)
        backButton.addTarget(self, action: #selector(removeAllDataWhenTapBackButton), for: .touchUpInside)
        return backButton
    }
    
    @objc func removeAllDataWhenTapBackButton() {
        self.navigationController?.popViewController(animated: true)
        MovieManager.shared.searchMovies.removeAll()
    }
}
extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return heightForRow
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        filmsTableView.deselectRow(at: indexPath, animated: true)
        guard let detailVC = storyboard?.instantiateViewController(withIdentifier: String(describing: DetailViewController.self)) as? DetailViewController else {return}
        
        detailVC.movie = MovieManager.shared.searchMovies[indexPath.row]
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let addToFavorite = UIContextualAction(style: .normal, title: "❤️") { (action, view, complitionHandler) in
            
            if !UserDefaultsManager.shared.titles.contains(MovieManager.shared.searchMovies[indexPath.row].title) {
                MovieManager.shared.favoriteMovies.append(MovieManager.shared.searchMovies[indexPath.row])
                UserDefaultsManager.shared.archivedData()
            } else {
                self.alertForAddToFavorite()
            }
            complitionHandler(true)
        }
        let swipe = UISwipeActionsConfiguration(actions: [addToFavorite])
        return swipe
    }
}

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MovieManager.shared.searchMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cell, for: indexPath) as? FilmsTableViewCell else {
            return UITableViewCell() }
        
        cell.setUpUI(model: MovieManager.shared.searchMovies[indexPath.row])
        return cell
    }
}

extension SearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        
        if self.searchBar.text == "" {
            MovieManager.shared.searchMovies.removeAll()
            self.filmsTableView.reloadData()
        } else {
            
            NetworkManager.shared.getSearchResults(searchTerm: searchBar.text ?? "") { (movies) in
                
                MovieManager.shared.searchMovies = movies
                DispatchQueue.main.async {
                    self.filmsTableView.reloadData()
                }
            }
        }
    }
}

extension SearchViewController: NetworkManagerDelegate {
    func didFailToMakeResponse() {
        let alert = UIAlertController(title: UserMessages.noFilmWithName, message: UserMessages.correctName, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: UserMessages.ok, style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

extension UISearchBar {

    func getTextField() -> UITextField? { return value(forKey: "searchField") as? UITextField }
    func setPlaceholderText(color: UIColor) { getTextField()?.setPlaceholderText(color: color) }
}

extension UITextField {

    func setPlaceholderText(color: UIColor) {
        attributedPlaceholder = NSAttributedString(string: placeholder != nil ? placeholder! : "", attributes: [.foregroundColor: color])
    }
}
