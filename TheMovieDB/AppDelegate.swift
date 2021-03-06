//
//  AppDelegate.swift
//  TheMovieDB
//
//  Created by Mohamed Abdul-Hameed on 10/20/18.
//  Copyright © 2018 Mohamed Abdul-Hameed. All rights reserved.
//

import UIKit

struct C: Codable {
    
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        SceneCoordinator.shared = SceneCoordinator(window: window)
        SceneCoordinator.shared.transition(to: Scene.nowPlaying) {
            window.makeKeyAndVisible()
        }
        
        return true
    }
}

