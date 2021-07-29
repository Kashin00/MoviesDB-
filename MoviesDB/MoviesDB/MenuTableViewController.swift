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
        
        let id = Genre.ganresArray[indexPath.row].id
        var array = [Movie]()

        let url = URL(string: "https://api.themoviedb.org/3/discover/movie?api_key=a19c5b2987101c209439576411e5c98f&with_genres=" + String(id))
        getSearchResults(url: url!) { (movies) in
            array = movies
        }
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let genreVC = storyboard.instantiateViewController(withIdentifier: "FilmsByGenreViewController") as? FilmsByGenreViewController {
            while array.isEmpty {
                print("e")
                sleep(1/2)
            }
            genreVC.movie = array
            navigationController?.pushViewController(genreVC, animated: true)
        }
    }
    
    func getSearchResults (url: URL, onCompletion: @escaping ([Movie]) -> ()) {
 
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { (data, responce, error) in
            guard let data = data else { return print(error!) }

            do {
                let movieData = try JSONDecoder().decode(MovieResponce.self, from: data)
                onCompletion(movieData.movies)
            } catch {
                print(error)
            }
        }.resume()
    }
}
