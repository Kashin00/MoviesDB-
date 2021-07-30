//
//  MenuTableViewController.swift
//  MoviesDB
//
//  Created by Матвей Кашин on 29.07.2021.
//

import UIKit

class MenuTableViewController: UITableViewController {
    private let menuCell = "menuCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: menuCell)
        navigationController?.navigationBar.barTintColor = .black
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Genre.ganresArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: menuCell, for: indexPath)
        cell.textLabel?.text = Genre.ganresArray[indexPath.row].name
        cell.backgroundColor = .black
        cell.textLabel?.textColor = .white
        return cell
    }
    // MARK: - Table view delegate

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let currentGenre = Genre.ganresArray[indexPath.row]
        NetworkManager.shared.getSearchResults(id: currentGenre.id) { (movies) in
            MovieManager.shared.genreArray = movies
        }
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let genreVC = storyboard.instantiateViewController(withIdentifier: "FilmsByGenreViewController") as? FilmsByGenreViewController {

            while MovieManager.shared.genreArray.isEmpty {
                sleep(1/9)
            }
            genreVC.getTitle = currentGenre.name
            genreVC.movie = MovieManager.shared.genreArray
            navigationController?.pushViewController(genreVC, animated: true)
            MovieManager.shared.genreArray.removeAll()
        }
    }
}
