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
    private let pullToRefreshIndicator = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()

    }
}

//MARK: -SetUpUI func
private extension HomeViewController {
    func setUpUI() {
        
        let titles = ["Popular", "Top rated", "Upcoming"]
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
        
        //MARK: -Refresh
        pullToRefreshIndicator.tintColor = .white
        pullToRefreshIndicator.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        filmsTableView.addSubview(pullToRefreshIndicator)
        
        MovieManager.shared.popularMovies.shuffle()
        MovieManager.shared.topRatedMovies.shuffle()
        MovieManager.shared.upcommingMovies.shuffle()
        sleep(1)
    }

    func alertForAddToFavorite() {
        let alert = UIAlertController(title: UserMessages.alreadyAdded, message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: UserMessages.ok, style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    @objc func segmentTarget() {
        
        switch segmentControl.selectedSegmentIndex {
        case 0:
            selectedSection = 0
        case 1:
            selectedSection = 1
        case 2:
            selectedSection = 2
        default:
            break
        }
        filmsTableView.reloadData()
    }
    
    @objc func refresh(_ sender: AnyObject) {
        switch segmentControl.selectedSegmentIndex {
        case 0:
            MovieManager.shared.popularMovies.shuffle()
        case 1:
            MovieManager.shared.topRatedMovies.shuffle()
        case 2:
            MovieManager.shared.upcommingMovies.shuffle()
        default:
            break
        }
        self.perform(#selector(endRefreshing), with: nil, afterDelay: 1)
    }
    @objc func endRefreshing() {
        filmsTableView.reloadData()
        pullToRefreshIndicator.endRefreshing()
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
        let addToFavorite = UIContextualAction(style: .normal, title: "❤️") { (action, view, complitionHandler) in
           
            switch self.selectedSection {
            case 0:
                if !UserDefaultsManager.shared.titles.contains(MovieManager.shared.popularMovies[indexPath.row].title) {
                    MovieManager.shared.favoriteMovies.append(MovieManager.shared.popularMovies[indexPath.row])
                    UserDefaultsManager.shared.archivedData()
                } else {
                    self.alertForAddToFavorite()
                }
            case 1:
                if !UserDefaultsManager.shared.titles.contains(MovieManager.shared.topRatedMovies[indexPath.row].title) {
                    MovieManager.shared.favoriteMovies.append(MovieManager.shared.topRatedMovies[indexPath.row])
                    UserDefaultsManager.shared.archivedData()
                }else {
                    self.alertForAddToFavorite()
                }
            case 2:
                if !UserDefaultsManager.shared.titles.contains(MovieManager.shared.upcommingMovies[indexPath.row].title) {
                    MovieManager.shared.favoriteMovies.append(MovieManager.shared.upcommingMovies[indexPath.row])
                    UserDefaultsManager.shared.archivedData()
                }else {
                    self.alertForAddToFavorite()
                }
            default:
                break
            }
            complitionHandler(true)
        }
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
        case 1:
            cell.setUpUI(model: MovieManager.shared.topRatedMovies[indexPath.row])
        case 2:
            cell.setUpUI(model: MovieManager.shared.upcommingMovies[indexPath.row])
        default:
            break
        }
        return cell
    }
}

