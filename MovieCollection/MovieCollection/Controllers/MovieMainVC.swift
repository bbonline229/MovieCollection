//
//  MovieMainVC.swift
//  MovieCollection
//
//  Created by Jack on 7/13/19.
//  Copyright © 2019 Jack. All rights reserved.
//

import UIKit

enum MovieComponent: CaseIterable {
    case movieList
    case favoriteMovie
}

class MovieMainVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private let movieComponent = MovieComponent.allCases
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
        setupTableView()
    }
    
    private func setup() {
        navigationItem.title = "首頁"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "設定", style: .done, target: self, action: #selector(setting))
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "MovieBaseCell", bundle: nil), forCellReuseIdentifier: "MovieBaseCell")
        tableView.tableFooterView = UIView()
    }
    
    @objc private func setting() {
        
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
            return cell
        case .favoriteMovie:
            cell.movieSource = .collection
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
            navigationController?.pushViewController(vc, animated: true)
        case .favoriteMovie:
            return
        }
    }
}
