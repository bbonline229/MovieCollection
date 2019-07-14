//
//  SettingService.swift
//  MovieCollection
//
//  Created by Jack on 7/14/19.
//  Copyright © 2019 Jack. All rights reserved.
//

import Foundation

class StorageService {
    private init() {}
    static let instance = StorageService()
    
    var settingMode: Setting {
        get {
            let mode = UserDefaults.standard.object(forKey: "mode") as? Int ?? 0
            return Setting(rawValue: mode) ?? .finite
        }
        
        set {
            UserDefaults.standard.set(newValue.rawValue, forKey: "mode")
            UserDefaults.standard.synchronize()
        }
    }
}
