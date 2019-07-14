//
//  MovieSettingVC.swift
//  MovieCollection
//
//  Created by Jack on 7/14/19.
//  Copyright © 2019 Jack. All rights reserved.
//

import UIKit

enum Setting: Int, CaseIterable {
    case finite = 0
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
    
    let settings = Setting.allCases
    
    let settingMode = StorageService.instance.settingMode
    
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
        return settings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell", for: indexPath)
        let setting = settings[indexPath.row]
        cell.textLabel?.text = setting.displayName
        cell.selectionStyle = .none
        cell.accessoryType = (settingMode == setting) ? .checkmark : .none
        
        return cell
    }
}

extension MovieSettingVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) else { return }
        tableView.visibleCells.forEach { (cell) in
            cell.accessoryType = .none
        }
        cell.accessoryType = .checkmark
        StorageService.instance.settingMode = Setting(rawValue: indexPath.row) ?? .finite
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) else { return }
        cell.accessoryType = .none
    }
}
