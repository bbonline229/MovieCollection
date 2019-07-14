//
//  MovieBaseCell.swift
//  MovieCollection
//
//  Created by Jack on 7/14/19.
//  Copyright © 2019 Jack. All rights reserved.
//

import UIKit
import RealmSwift

class MovieBaseCell: UITableViewCell {
    
    @IBOutlet weak var movieCountLabel: UILabel!
    
    var movieSource: MovieListSource = .hotMovie {
        didSet {
            textLabel?.text = movieSource.displayName
        }
    }
    
    var movieData: [Movie] = [] {
        didSet {
            movieCountLabel.text = "\(movieData.count)"
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
        accessoryType = .disclosureIndicator
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
