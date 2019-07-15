//
//  Movie.swift
//  MovieCollection
//
//  Created by Jack on 7/13/19.
//  Copyright © 2019 Jack. All rights reserved.
//

import Foundation
import RealmSwift

class MovieCollection: Codable {
    let movieData: [Movie]
    
    private enum CodingKeys: String, CodingKey {
        case movieData = "images"
    }
}

class Movie: Object, Codable {
    @objc dynamic var title = ""
    @objc dynamic var url = ""
    
    var titleDescription: String {
        return "片名: \(title)"
    }
}

extension Movie {
    convenience init(title: String, url: String) {
        self.init()
        
        self.title = title
        self.url = url
    }
}

extension Movie {
    static func likeMovie(in realm: Realm = try! Realm(), query: String) -> Results<Movie>? {
        let predicate = NSPredicate(format: "title=%@", query)
        return realm.objects(Movie.self).filter(predicate)
    }
    
    static func allLikeMovie(in realm: Realm = try! Realm()) -> Results<Movie> {
        return realm.objects(Movie.self)
    }
    
    func save(in realm: Realm = try! Realm()) {
        do {
            try realm.write {
                realm.add(self)
            }
        } catch {
            print("Realm save error: \(error)")
        }
    }
    
    func delete() {
        guard let realm = realm else {return}
        
        do {
            try realm.write {
                realm.delete(self)
            }
        } catch {
            print("Realm delete error: \(error)")
        }
    }
}
