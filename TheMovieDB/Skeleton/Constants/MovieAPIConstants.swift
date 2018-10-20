//
//  MovieAPIConstants.swift
//  TheMovieDB
//
//  Created by Mohamed Abdul-Hameed on 10/20/18.
//  Copyright © 2018 Mohamed Abdul-Hameed. All rights reserved.
//

extension Constants {
    enum MovieAPIConstants {
        
        /// API Key
        static let APIKey = (key: "api_key", value: "cccb9ec4f2fadd35d3b0591378f2b4bd")
        
        /// Base URL
        static let baseURL = "https://api.themoviedb.org/3/"
        
        /// Images URL
        static let imagesURL = "https://image.tmdb.org/t/p/"
        
        /// Small image
        static let smallImage = "w185/"
        
        /// Original image
        static let originalImage = "original/"
        
        /// Now Playing API
        static let nowPlaying = "movie/now_playing"
        
        /// page key for now playing API
        static let page = "page"
    }
}
