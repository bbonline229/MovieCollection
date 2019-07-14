//
//  AppDelegate.swift
//  MovieCollection
//
//  Created by Jack on 7/13/19.
//  Copyright © 2019 Jack. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        initSetup()
        
        return true
    }
    
    private func initSetup() {
        UINavigationBar.appearance().tintColor = UIColor.darkGray
        
        let vc = MovieMainVC()
        let mainNav = UINavigationController(rootViewController: vc)
        
        window =  UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .white
        window?.rootViewController = mainNav
        window?.makeKeyAndVisible()
    }

}

