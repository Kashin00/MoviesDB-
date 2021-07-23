//
//  ViewController.swift
//  MoviesDB
//
//  Created by Матвей Кашин on 20.07.2021.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak private var filmsTableView: UITableView!
    private var segmentControl: UISegmentedControl!
    @IBOutlet weak private var searchBar: UISearchBar!
    private let cell = String(describing: FilmsTableViewCell.self)
    private let heightForRow = CGFloat(100)
    private var moviesArray = [Movie]()
    
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
   
        }else if segmentControl.selectedSegmentIndex == 1 {
            
        }else if segmentControl.selectedSegmentIndex == 2 {
 
        }
        filmsTableView.reloadData()
    }
    
    //MARK: -Add to favorite swipe
     func addToFavorite(rowIndexPath indexPath: IndexPath) -> UIContextualAction {
        let addToFavotrite = UIContextualAction(style: .destructive, title: "🤍") { (_, _, _) in
            //add to favorite
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
        filmsTableView.deselectRow(at: indexPath, animated: true)
        
        guard let detailVC = storyboard?.instantiateViewController(withIdentifier: String(describing: DetailViewController.self)) as? DetailViewController else {return}

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
//        return moviesArray.count
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cell, for: indexPath) as? FilmsTableViewCell else {
    return UITableViewCell() }
        
        
        return cell
    }
}

//MARK: -UISearchBarDelegate
extension HomeViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        searchBar.resignFirstResponder()
    }
}
