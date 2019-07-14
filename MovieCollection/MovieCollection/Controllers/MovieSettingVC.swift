//
//  MovieSettingVC.swift
//  MovieCollection
//
//  Created by Jack on 7/14/19.
//  Copyright © 2019 Jack. All rights reserved.
//

import UIKit

enum Setting: CaseIterable {
    case finite
    case infinite
    
    var displayName: String {
        switch self {
        case .finite:
            return "不循環"
        case .infinite:
            return "循環"
        }
    }
}

class MovieSettingVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let setting = Setting.allCases
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
        setupTableView()
    }
    
    private func setup() {
        navigationItem.title = "顯示設定"
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "tableViewCell")
    }

}

extension MovieSettingVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return setting.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell", for: indexPath)
        cell.textLabel?.text = setting[indexPath.row].displayName
        cell.selectionStyle = .none
        
        return cell
    }
}

extension MovieSettingVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) else { return }
        cell.accessoryType = .checkmark
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) else { return }
        cell.accessoryType = .none
    }
}
