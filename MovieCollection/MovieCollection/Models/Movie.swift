//
//  Movie.swift
//  MovieCollection
//
//  Created by Jack on 7/13/19.
//  Copyright © 2019 Jack. All rights reserved.
//

import Foundation

struct MovieCollection: Codable {
    let images: [Movie]
}

struct Movie: Codable {
    let title: String
    let url: String
}
