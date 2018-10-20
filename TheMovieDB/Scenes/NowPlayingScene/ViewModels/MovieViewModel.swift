//
//  MovieViewModel.swift
//  TheMovieDB
//
//  Created by Mohamed Abdul-Hameed on 10/20/18.
//  Copyright © 2018 Mohamed Abdul-Hameed. All rights reserved.
//

import Foundation

struct MovieViewModel {
    let title: String
    let overview: String
    let originalPosterPath: URL
    let smallPosterPath: URL
    let originalBackdropPath: URL
    let smallBackdropPath: URL
    
    init(with movie: Movie) {
        title = movie.title
        overview = movie.overview
        
        // PosterURL
        
        if let posterPathString = movie.posterPath,
            let originalPosterPathURL = URL(string: "\(Constants.MovieAPIConstants.imagesURL)\(Constants.MovieAPIConstants.originalImage)\(posterPathString)"),
            let smallPosterPathURL = URL(string: "\(Constants.MovieAPIConstants.imagesURL)\(Constants.MovieAPIConstants.smallImage)\(posterPathString)") {
            
            originalPosterPath = originalPosterPathURL
            smallPosterPath = smallPosterPathURL
            
        } else {
            originalPosterPath = URL(string: "https://cdn.pixabay.com/photo/2017/02/12/21/29/false-2061132_1280.png")!
            smallPosterPath = URL(string: "https://cdn.pixabay.com/photo/2017/02/12/21/29/false-2061132_1280.png")!
        }
        
        // BackdropURL
        
        if let backdropPathString = movie.backdropPath, let originalBackdropPathURL = URL(string: "\(Constants.MovieAPIConstants.imagesURL)\(Constants.MovieAPIConstants.originalImage)\(backdropPathString)"),
            let smallBackdropPathURL = URL(string: "\(Constants.MovieAPIConstants.imagesURL)\(Constants.MovieAPIConstants.smallImage)\(backdropPathString)") {
            
            originalBackdropPath = originalBackdropPathURL
            smallBackdropPath = smallBackdropPathURL
        } else {
            originalBackdropPath = URL(string: "https://cdn.pixabay.com/photo/2017/02/12/21/29/false-2061132_1280.png")!
            smallBackdropPath = URL(string: "https://cdn.pixabay.com/photo/2017/02/12/21/29/false-2061132_1280.png")!
        }
    }
}
