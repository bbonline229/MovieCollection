//
//  MovieCollectionVC.swift
//  MovieCollection
//
//  Created by Jack on 7/13/19.
//  Copyright © 2019 Jack. All rights reserved.
//

import UIKit
import RealmSwift

enum MovieListSource {
    case hotMovie
    case collection
    
    var displayName: String {
        switch self {
        case .hotMovie:
            return "熱門電影"
        default:
            return "我的收藏"
        }
    }
}

class MovieListVC: UIViewController {

    @IBOutlet weak var listTitleLabel: UILabel!
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
    
    let doneButton: UIButton = {
        let button = UIButton()
        button.setTitle("完成", for: .normal)
        button.backgroundColor = .crazyBlue
        button.addTarget(self, action: #selector(toggleDone), for: .touchUpInside)
        return button
    }()
    
    var currentPage: Int = 0 {
        didSet {
            let animated = abs(currentPage - oldValue) > 1 ? false : true
            collectionView.scrollToItem(at: IndexPath(item: currentPage, section: 0), at: .centeredHorizontally, animated: animated)
            pageControl.currentPage = currentPage
            self.currentPageLabel.text = "\(currentPage + 1) of \(movieData.count)"
        }
    }
    
    var movieData: [Movie] = []
    
    var listSource: MovieListSource = .hotMovie
    let settingMode = StorageService.instance.settingMode
    
    
    private let netWorkService = NetWorkService()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
        setupCollectionView()
        setupPageControl(ishidden: false)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        setupToggleButton()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.navigationBar.isHidden = false
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    private func setup() {
        navigationController?.navigationBar.isHidden = true
        
        listTitleLabel.text = listSource.displayName
        
        pageControl.currentPage = currentPage
        pageControl.pageIndicatorTintColor = .lightBlue
        pageControl.currentPageIndicatorTintColor = .crazyBlue
        pageControl.numberOfPages = movieData.count
        
        currentPageLabel.text = "1 of \(movieData.count)"
    }
    
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.collectionViewLayout = layout
        collectionView.isPagingEnabled = true
        collectionView.register(UINib(nibName: "MovieDetailCell", bundle: nil), forCellWithReuseIdentifier: "MovieDetailCell")
        collectionView.showsHorizontalScrollIndicator = false
    }
    
    private func setupPageControl(ishidden: Bool) {
        pageControl.numberOfPages = movieData.count
        pageControl.isHidden = ishidden
        pageControlHeight.constant = ishidden ? 0 : 20
        
        view.layoutIfNeeded()
    }
    
    private func setupToggleButton() {
        if movieData.count == 1 {
            containView.addSubview(doneButton)
            doneButton.fillSuperview()
        } else {
            containView.addSubview(previousButton)
            containView.addSubview(nextButton)
        
            previousButton.anchor(top: containView.topAnchor, leading: containView.leadingAnchor, bottom: containView.bottomAnchor, trailing: nil, padding: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0), size: CGSize(width: containView.bounds.width / 2, height: 0))
            nextButton.anchor(top: containView.topAnchor, leading: previousButton.trailingAnchor, bottom: containView.bottomAnchor, trailing: containView.trailingAnchor, padding: UIEdgeInsets(top: 0, left: 1, bottom: 0, right: 0))
        }
    }
    
    @objc private func toggleToPreviousPage() {
        if currentPage == 0 {
            if settingMode == .infinite { currentPage = movieData.count - 1 }
            return
        }
        currentPage -= 1
    }
    
    @objc private func toggleToNextPage() {
        if currentPage == movieData.count - 1 {
            if settingMode == .infinite { currentPage = 0 }
            return
        }
        currentPage += 1
    }
    
    @objc private func toggleDone() {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func pageNavigate(_ sender: UIPageControl) {
        currentPage = sender.currentPage
    }
    
    @IBAction func goBack(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
}

extension MovieListVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieDetailCell", for: indexPath) as! MovieDetailCell
        cell.movie = movieData[indexPath.row]
        return cell
    }
}

extension MovieListVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let x = scrollView.contentOffset.x
        let w = scrollView.bounds.size.width
        let currentPage = Int(ceil(x/w))
        self.currentPage = currentPage
    }
}
