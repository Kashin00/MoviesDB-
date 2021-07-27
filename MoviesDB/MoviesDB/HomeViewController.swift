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
        sleep(1)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        filmsTableView.reloadData()
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
            
            var titles = [String]()
            MovieManager.shared.favoriteMovies.forEach{
                titles.append($0.title)
            }
            
            switch self.selectedSection {
            case 0:
                if !titles.contains(MovieManager.shared.popularMovies[indexPath.row].title) {
                    MovieManager.shared.favoriteMovies.append(MovieManager.shared.popularMovies[indexPath.row])
                    archivedData()
                }
            case 1:
                if !titles.contains(MovieManager.shared.topRatedMovies[indexPath.row].title) {
                    MovieManager.shared.favoriteMovies.append(MovieManager.shared.topRatedMovies[indexPath.row])
                    archivedData()
                }
            case 2:
                if !titles.contains(MovieManager.shared.upcommingMovies[indexPath.row].title) {
                    MovieManager.shared.favoriteMovies.append(MovieManager.shared.upcommingMovies[indexPath.row])
                    archivedData()
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

func archivedData() {
    do {
        let encodeData = try NSKeyedArchiver.archivedData(withRootObject: MovieManager.shared.favoriteMovies, requiringSecureCoding: false)
        UserDefaults.standard.set(encodeData, forKey: "items")
    } catch {
        print(error)
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

