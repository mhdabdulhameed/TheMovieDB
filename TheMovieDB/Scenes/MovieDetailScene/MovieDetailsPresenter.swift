//
//  MovieDetailsPresenter.swift
//  TheMovieDB
//
//  Created by Mohamed Abdul-Hameed on 10/20/18.
//  Copyright © 2018 Mohamed Abdul-Hameed. All rights reserved.
//

import Foundation

protocol MovieDetailsPresentationLogic: class {
    
    /// Returns the movie's poster `URL`.
    var moviePosterURL: URL { get }
    
    /// Returns the movie's title.
    var movieTitle: String { get }
    
    /// Returns the movie's overview.
    var movieOverview: String { get }
}

final class MovieDetailsPresenter: MovieDetailsPresentationLogic {
    
    weak var viewController: MovieDetailsDisplayLogic?
    
    private let networkManager: NetworkManager
    private let movie: MovieViewModel
    
    /// Initializes the `MovieDetailsPresenter`.
    ///
    /// - Parameters:
    ///   - networkManager: An instance of any class that conforms to `NetworkManager`.
    ///   - movie: An instance of `MovieViewModel` of the movie that is being displayed.
    init(networkManager: NetworkManager = MoyaNetworkManager.shared, movie: MovieViewModel) {
        self.networkManager = networkManager
        self.movie = movie
    }
    
    // MARK: - MovieDetailsPresentationLogic Protocol Conformance
    
    var moviePosterURL: URL {
        return movie.originalBackdropPath
    }
    
    var movieTitle: String {
        return movie.title
    }
    
    var movieOverview: String {
        return movie.overview
    }
}
