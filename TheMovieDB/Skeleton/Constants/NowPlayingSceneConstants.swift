//
//  NowPlayingSceneConstants.swift
//  TheMovieDB
//
//  Created by Mohamed Abdul-Hameed on 10/20/18.
//  Copyright © 2018 Mohamed Abdul-Hameed. All rights reserved.
//

import UIKit
import Foundation

extension Constants {
    enum NowPlayingSceneConstants {
        
        /// Scene title
        static let title = NSLocalizedString("Movies", comment: "Now Playing Screen Title")
        
        /// Scene colors
        static let foregroundColor = UIColor.white
        static let backgroundColor = UIColor(red: 20.0/255.0, green: 20.0/255.0, blue: 20.0/255.0, alpha: 255.0)
        
        /// Searchbar place holder
        static let searchbarPlaceHolder = NSLocalizedString("Search for movies...", comment: "The place holder of the search bar of main screen")
    }
}
