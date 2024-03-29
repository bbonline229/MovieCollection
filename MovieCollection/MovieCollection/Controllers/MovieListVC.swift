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
    
    private let doneButton: UIButton = {
        let button = UIButton()
        button.setTitle("完成", for: .normal)
        button.backgroundColor = .crazyBlue
        button.addTarget(self, action: #selector(toggleDone), for: .touchUpInside)
        return button
    }()
    
    var movieData: [Movie] = []
    
    var page: Page! {
        didSet {
            guard let _ = oldValue else { return }
            
            let animated = abs(page.currentPageIndex - oldValue.currentPageIndex) > 1 ? false : true
            collectionView.scrollToItem(at: IndexPath(item: page.currentPageIndex, section: 0), at: .centeredHorizontally, animated: animated)
            
            pageControl.currentPage = page.currentPageIndex
            self.currentPageLabel.text = page.pageDescription
        }
    }
    
    var listSource: MovieListSource = .hotMovie
    let settingMode = StorageService.instance.settingMode
    
    
    private let netWorkService = NetWorkService()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
        setupCollectionView()
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
        
        page = Page(currentPageIndex: 0, totalPage: movieData.count)
        
        pageControl.currentPage = page.currentPageIndex
        pageControl.pageIndicatorTintColor = .lightBlue
        pageControl.currentPageIndicatorTintColor = .crazyBlue
        pageControl.numberOfPages = movieData.count
        setupPageControl(ishidden: movieData.count <= 1)
        
        currentPageLabel.text = page.pageDescription
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
        page.toggleToPreviousPage(with: settingMode)
    }
    
    @objc private func toggleToNextPage() {
        page.toggleToNextPage(with: settingMode)
    }
    
    @objc private func toggleDone() {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func pageNavigate(_ sender: UIPageControl) {
        page.currentPageIndex = sender.currentPage
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
        page.currentPageIndex = currentPage
    }
}
