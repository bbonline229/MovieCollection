//
//  MovieCollectionVC.swift
//  MovieCollection
//
//  Created by Jack on 7/13/19.
//  Copyright © 2019 Jack. All rights reserved.
//

import UIKit

class MovieCollectionVC: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var containView: UIView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    private let previousButton: UIButton = {
        let button = UIButton()
        button.setTitle("上一頁", for: .normal)
        button.addTarget(self, action: #selector(toggleToPreviousPage), for: .touchUpInside)
        return button
    }()
    
    private let nextButton: UIButton = {
        let button = UIButton()
        button.setTitle("下一頁", for: .normal)
        button.addTarget(self, action: #selector(toggleToNextPage), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @objc private func toggleToPreviousPage() {
        
    }
    
    @objc private func toggleToNextPage() {
        
    }

}
