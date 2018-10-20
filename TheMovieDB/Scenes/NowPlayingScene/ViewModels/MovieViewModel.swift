//
//  MovieViewModel.swift
//  TheMovieDB
//
//  Created by Mohamed Abdul-Hameed on 10/20/18.
//  Copyright © 2018 Mohamed Abdul-Hameed. All rights reserved.
//

import Foundation

struct MovieViewModel {
    
    /// The title of the movie.
    let title: String
    
    /// The overview of the movie.
    let overview: String
    
    /// The path of the original poster.
    let originalPosterPath: URL
    
    /// The path of a smaller version poster.
    let smallPosterPath: URL
    
    /// The path of the original backdrop.
    let originalBackdropPath: URL
    
    /// The path of a smaller version of the backdrop.
    let smallBackdropPath: URL
    
    /// Initializes the `MovieViewModel` using `Movie` instance.
    ///
    /// - Parameter movie: An instance of `Movie`.
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
            
            // A default image to be used if the poster image path was not available.
            
            originalPosterPath = URL(string: "https://cdn.pixabay.com/photo/2017/02/12/21/29/false-2061132_1280.png")!
            smallPosterPath = URL(string: "https://cdn.pixabay.com/photo/2017/02/12/21/29/false-2061132_1280.png")!
        }
        
        // BackdropURL
        
        if let backdropPathString = movie.backdropPath, let originalBackdropPathURL = URL(string: "\(Constants.MovieAPIConstants.imagesURL)\(Constants.MovieAPIConstants.originalImage)\(backdropPathString)"),
            let smallBackdropPathURL = URL(string: "\(Constants.MovieAPIConstants.imagesURL)\(Constants.MovieAPIConstants.smallImage)\(backdropPathString)") {
            
            originalBackdropPath = originalBackdropPathURL
            smallBackdropPath = smallBackdropPathURL
        } else {
            
            // A default image to be used if the backdrop image path was not available.
            
            originalBackdropPath = URL(string: "https://cdn.pixabay.com/photo/2017/02/12/21/29/false-2061132_1280.png")!
            smallBackdropPath = URL(string: "https://cdn.pixabay.com/photo/2017/02/12/21/29/false-2061132_1280.png")!
        }
    }
}
