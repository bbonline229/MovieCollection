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

    @IBOutlet weak var likeImageView: UIImageView!
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var movieImageView: UIImageView!
    
    var movie: Movie! {
        didSet {
            movieNameLabel.text = movie.titleDescription
            movieImageView.kf.setImage(with: URL(string: movie.url))
            
            let likeMovie = Movie.likeMovie(query: movie.title)?.first
            likeImageView.image = (likeMovie != nil) ? #imageLiteral(resourceName: "Icon_Like") : #imageLiteral(resourceName: "Icon-Unlike")
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        likeImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(toggleLike)))
        likeImageView.isUserInteractionEnabled = true
    }
    
    func checkLike() -> Bool {
        let like = Movie.likeMovie(query: movie.title)?.first
        
        if let like = like {
            like.delete()
            return false
        } else {
            let likeMovie = Movie(title: movie.title, url: movie.url)
            likeMovie.save()
            return true
        }
    }
    
    @objc func toggleLike() {
        likeImageView.image = checkLike() ? #imageLiteral(resourceName: "Icon_Like") : #imageLiteral(resourceName: "Icon-Unlike")
    }

}
