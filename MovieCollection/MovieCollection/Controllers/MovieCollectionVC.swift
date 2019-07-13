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
    @IBOutlet weak var currentPageLabel: UILabel!
    @IBOutlet weak var pageControlHeight: NSLayoutConstraint!
    
    private let previousButton: UIButton = {
        let button = UIButton()
        button.setTitle("上一頁", for: .normal)
        button.backgroundColor = .crazyBlue
        button.addTarget(self, action: #selector(toggleToPreviousPage), for: .touchUpInside)
        return button
    }()
    
    private let nextButton: UIButton = {
        let button = UIButton()
        button.setTitle("下一頁", for: .normal)
        button.backgroundColor = .crazyBlue
        button.addTarget(self, action: #selector(toggleToNextPage), for: .touchUpInside)
        return button
    }()
    
    var currentPage: Int = 0 {
        didSet {
            
        }
    }
    
    private let netWorkService = NetWorkService()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
        setupPageControl(ishidden: false)
        
        requestMovies()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        setupToggleButton()
    }
    
    private func setup() {
        navigationController?.navigationBar.isHidden = true
        
        pageControl.currentPage = currentPage
        pageControl.pageIndicatorTintColor = .lightBlue
        pageControl.currentPageIndicatorTintColor = .crazyBlue
    }
    
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        collectionView.collectionViewLayout = layout
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
    }
    
    private func setupPageControl(ishidden: Bool) {
        pageControl.isHidden = ishidden
        pageControlHeight.constant = ishidden ? 0 : 20
        
        view.layoutIfNeeded()
    }
    
    private func setupToggleButton() {
        containView.addSubview(previousButton)
        containView.addSubview(nextButton)
        
        previousButton.anchor(top: containView.topAnchor, leading: containView.leadingAnchor, bottom: containView.bottomAnchor, trailing: nil, padding: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0), size: CGSize(width: containView.bounds.width / 2, height: 0))
        nextButton.anchor(top: containView.topAnchor, leading: previousButton.trailingAnchor, bottom: containView.bottomAnchor, trailing: containView.trailingAnchor, padding: UIEdgeInsets(top: 0, left: 1, bottom: 0, right: 0))
    }
    
    private func requestMovies() {
        guard let url = URL(string: "https://mu7d7a3b5l.execute-api.ap-northeast-1.amazonaws.com/staging/images") else { return }
        let resource = Resource<MovieCollection>(url: url)
        
        netWorkService.load(resource: resource) { [weak self] (movie) in
            print(movie)
        }
        
    }
    
    @objc private func toggleToPreviousPage() {
        
    }
    
    @objc private func toggleToNextPage() {
        
    }

}
