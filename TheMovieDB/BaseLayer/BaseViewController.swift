//
//  BaseViewController.swift
//  TheMovieDB
//
//  Created by Mohamed Abdul-Hameed on 10/20/18.
//  Copyright © 2018 Mohamed Abdul-Hameed. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customizeUI()
    }
    
    private func customizeUI() {
        // Colors
        let backgroundColor = Constants.NowPlayingSceneConstants.backgroundColor
        let foregroundColor = Constants.NowPlayingSceneConstants.foregroundColor
        view.backgroundColor = backgroundColor
        navigationController?.navigationBar.tintColor = foregroundColor
        navigationController?.navigationBar.barTintColor = .clear
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: foregroundColor]
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: foregroundColor]
        
        // Properties
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}
