//
//  ViewController.swift
//  MoviesDB
//
//  Created by Матвей Кашин on 20.07.2021.
//

import UIKit
import SDWebImage

class HomeViewController: UIViewController {
    
    @IBOutlet weak private var filmsTableView: UITableView!
    private var segmentControl: UISegmentedControl!
    private let cell = String(describing: FilmsTableViewCell.self)
    private let heightForRow = CGFloat(100)
    private var selectedSection = 0
   
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpUI()
    }
}

//MARK: -SetUpUI func
private extension HomeViewController {
    func setUpUI() {
        
        let titles = ["Popular", "Top rated", "Upcomming"]
        segmentControl = UISegmentedControl(items: titles)
        segmentControl.tintColor = UIColor.white
        segmentControl.backgroundColor = UIColor.gray
        segmentControl.selectedSegmentIndex = 0
        for index in 0...titles.count-1 {
            segmentControl.setWidth(85, forSegmentAt: index)
        }
        segmentControl.sizeToFit()
        segmentControl.selectedSegmentIndex = 0
        segmentControl.addTarget(self, action: #selector(segmentTarget), for: .valueChanged)
        navigationItem.titleView = segmentControl
        filmsTableView.register(UINib.init(nibName: cell, bundle: nil), forCellReuseIdentifier: cell)
    }
    
    @objc func segmentTarget() {
        if segmentControl.selectedSegmentIndex == 0 {
            selectedSection = 0
        }else if segmentControl.selectedSegmentIndex == 1 {
            selectedSection = 1
        }else if segmentControl.selectedSegmentIndex == 2 {
            selectedSection = 2
        }
        filmsTableView.reloadData()
    }
    
    //MARK: -Add to favorite swipe
     func addToFavorite(rowIndexPath indexPath: IndexPath) -> UIContextualAction {
        let addToFavotrite = UIContextualAction(style: .destructive, title: "🤍") { (_, _, _) in
                        
            switch self.selectedSection {
            case 0:
                if !MovieManager.shared.favoriteMovies.contains(MovieManager.shared.popularMovies[indexPath.row]) {
                    MovieManager.shared.favoriteMovies.append(MovieManager.shared.popularMovies[indexPath.row])
                }
            case 1:
                if !MovieManager.shared.favoriteMovies.contains(MovieManager.shared.topRatedMovies[indexPath.row]) {
                    MovieManager.shared.favoriteMovies.append(MovieManager.shared.topRatedMovies[indexPath.row])
                }
            case 2:
                if !MovieManager.shared.favoriteMovies.contains(MovieManager.shared.upcommingMovies[indexPath.row]) {
                    MovieManager.shared.favoriteMovies.append(MovieManager.shared.upcommingMovies[indexPath.row])
                }
            default:
                break
            }
            print( MovieManager.shared.favoriteMovies.count)
        }
        
        addToFavotrite.backgroundColor = .red
        return addToFavotrite
    }
}
//MARK: - UITableViewDelegate
extension HomeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return heightForRow
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let detailVC = storyboard?.instantiateViewController(withIdentifier: String(describing: DetailViewController.self)) as? DetailViewController else {return}
        switch selectedSection {
        case 0:
            detailVC.movie = MovieManager.shared.popularMovies[indexPath.row]
        case 1:
            detailVC.movie = MovieManager.shared.topRatedMovies[indexPath.row]
        case 2:
            detailVC.movie = MovieManager.shared.upcommingMovies[indexPath.row]
        default:
            break
        }
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let addToFavorite = self.addToFavorite(rowIndexPath: indexPath)
        let swipe = UISwipeActionsConfiguration(actions: [addToFavorite])
        return swipe
    }
}
//MARK: -UITAbleViewDataSource
extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        switch selectedSection {
        case 0:
            return MovieManager.shared.popularMovies.count
        case 1:
            return MovieManager.shared.topRatedMovies.count
        case 2:
            return MovieManager.shared.upcommingMovies.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cell, for: indexPath) as? FilmsTableViewCell else {
    return UITableViewCell() }
        
        switch selectedSection {
        case 0:
            cell.setUpUI(model: MovieManager.shared.popularMovies[indexPath.row])
            cell.imageSender = { image in
                MovieManager.shared.popularMovies[indexPath.row].image = image
            }
        case 1:
            cell.setUpUI(model: MovieManager.shared.topRatedMovies[indexPath.row])
            cell.imageSender = { image in
                MovieManager.shared.topRatedMovies[indexPath.row].image = image
            }
        case 2:
            cell.setUpUI(model: MovieManager.shared.upcommingMovies[indexPath.row])
            cell.imageSender = { image in
                MovieManager.shared.upcommingMovies[indexPath.row].image = image
            }
        default:
            break
        }
        return cell
    }
}

