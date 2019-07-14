//
//  MovieMainVC.swift
//  MovieCollection
//
//  Created by Jack on 7/13/19.
//  Copyright © 2019 Jack. All rights reserved.
//

import UIKit
import RealmSwift

enum MovieComponent: CaseIterable {
    case movieList
    case favoriteMovie
}

class MovieMainVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var movieData: [Movie] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    private let movieComponent = MovieComponent.allCases
    private let netWorkService = NetWorkService()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
        setupTableView()
        requestMovies()
    }
    
    private func setup() {
        navigationItem.title = "首頁"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "Setting-Small"), style: .done, target: self, action: #selector(setting))
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.bounces = false
        tableView.register(UINib(nibName: "MovieBaseCell", bundle: nil), forCellReuseIdentifier: "MovieBaseCell")
        tableView.tableFooterView = UIView()
    }
    
    private func requestMovies() {
        guard let url = URL(string: "https://mu7d7a3b5l.execute-api.ap-northeast-1.amazonaws.com/staging/images") else { return }
        let resource = Resource<MovieCollection>(url: url)
        
        netWorkService.load(resource: resource) { [weak self] (movie) in
            guard let movie = movie else { return }
            
            DispatchQueue.main.async {
                self?.movieData = movie.movieData
            }
        }
    }
    
    @objc private func setting() {
        let vc = MovieSettingVC()
        navigationController?.pushViewController(vc, animated: true)
    }

}

extension MovieMainVC: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return movieComponent.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch movieComponent[section] {
        case .movieList:
            return 1
        case .favoriteMovie:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch movieComponent[section] {
        case .movieList:
            return "列表"
        case .favoriteMovie:
            return "自訂"
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieBaseCell", for: indexPath) as! MovieBaseCell
        switch movieComponent[indexPath.section] {
        case .movieList:
            cell.movieSource = .hotMovie
            cell.movieData = movieData
            return cell
        case .favoriteMovie:
            cell.movieSource = .collection
            cell.movieData = movieData
            return cell
        }
    }
    
}

extension MovieMainVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch  movieComponent[indexPath.section] {
        case .movieList:
            let vc = MovieListVC()
            vc.listSource = .hotMovie
            vc.movieData = movieData
            navigationController?.pushViewController(vc, animated: true)
        case .favoriteMovie:
            return
        }
    }
}
