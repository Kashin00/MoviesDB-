//
//  UserDefaults.swift
//  MoviesDB
//
//  Created by Матвей Кашин on 28.07.2021.
//

import Foundation

class UserDefaultsManager {
    
    static var shared = UserDefaultsManager()
  
    var titles: [String] {
        var titles = [String]()
        MovieManager.shared.favoriteMovies.forEach{
            titles.append($0.title)
        }
        
        return titles
    }
    func archivedData() {
        
        do {
            let encodeData = try NSKeyedArchiver.archivedData(withRootObject: MovieManager.shared.favoriteMovies, requiringSecureCoding: false)
            UserDefaults.standard.set(encodeData, forKey: "items")
        } catch {
            print(error)
        }
    }
    
    func unArchivedData() {
        guard let data = UserDefaults.standard.object(forKey: "items") as? Data else { return }
        guard let movie = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? [Movie] else { return }
        MovieManager.shared.favoriteMovies = movie
    }
}
