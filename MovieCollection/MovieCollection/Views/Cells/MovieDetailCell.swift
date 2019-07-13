//
//  MovieDetailCell.swift
//  MovieCollection
//
//  Created by Jack on 7/13/19.
//  Copyright © 2019 Jack. All rights reserved.
//

import UIKit
import Kingfisher

class MovieDetailCell: UICollectionViewCell {

    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var movieImageView: UIImageView!
    
    var movie: Movie! {
        didSet {
            movieNameLabel.text = movie.title
            movieImageView.kf.setImage(with: URL(string: movie.url))
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
    }

}
