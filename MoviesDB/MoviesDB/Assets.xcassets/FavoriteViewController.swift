//
//  FavoriteViewController.swift
//  MoviesDB
//
//  Created by Матвей Кашин on 20.07.2021.
//

import UIKit
import SDWebImage

class FavoriteViewController: UIViewController {
    
    @IBOutlet weak private var filmsTableView: UITableView!
    private let cell = String(describing: FilmsTableViewCell.self)
    private let heightForRow = CGFloat(100)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        filmsTableView.register(UINib.init(nibName: cell, bundle: nil), forCellReuseIdentifier: cell)
//        MovieManager.shared.favoriteMovies = try! NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(UserDefaults.standard.object(forKey: "items") as! Data) as! [Movie]
        UserDefaultsManager.shared.unArchivedData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        filmsTableView.reloadData()
        if !MovieManager.shared.favoriteMovies.isEmpty {
//            MovieManager.shared.favoriteMovies = try! NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(UserDefaults.standard.object(forKey: "items") as! Data) as! [Movie]
            UserDefaultsManager.shared.unArchivedData()

        }
    }
}

extension FavoriteViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return heightForRow
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        switch editingStyle {
        case .delete:
            MovieManager.shared.favoriteMovies.remove(at: indexPath.row)
            filmsTableView.deleteRows(at: [indexPath], with: .left)
    
            UserDefaultsManager.shared.archivedData()
//            do {
//                let encodeData = try NSKeyedArchiver.archivedData(withRootObject: MovieManager.shared.favoriteMovies, requiringSecureCoding: false)
//                UserDefaults.standard.set(encodeData, forKey: "items")
//            } catch {
//                print(error)
//            }
        default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        filmsTableView.deselectRow(at: indexPath, animated: true)
        
        guard let detailVC = storyboard?.instantiateViewController(withIdentifier: String(describing: DetailViewController.self)) as? DetailViewController else {return}
        
        detailVC.movie = MovieManager.shared.favoriteMovies[indexPath.row]
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

extension FavoriteViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MovieManager.shared.favoriteMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cell, for: indexPath) as? FilmsTableViewCell else {
            return UITableViewCell()
        }
        cell.setUpUI(model: MovieManager.shared.favoriteMovies[indexPath.row])
        return cell
    }
    
    
}
