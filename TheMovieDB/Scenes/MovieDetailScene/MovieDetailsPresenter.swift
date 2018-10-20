//
//  MovieDetailsPresenter.swift
//  TheMovieDB
//
//  Created by Mohamed Abdul-Hameed on 10/20/18.
//  Copyright © 2018 Mohamed Abdul-Hameed. All rights reserved.
//

import Foundation

protocol MovieDetailsPresentationLogic: class {
    var posterURL: URL { get }
}

final class MovieDetailsPresenter: MovieDetailsPresentationLogic {
    
    weak var viewController: MovieDetailsDisplayLogic?
    
    private let networkManager: NetworkManager
    private let movie: MovieViewModel
    
    init(networkManager: NetworkManager = MoyaNetworkManager.shared, movie: MovieViewModel) {
        self.networkManager = networkManager
        self.movie = movie
    }
    
    // MARK: - MovieDetailsPresentationLogic Protocol Conformance
    
    var posterURL: URL {
        return movie.originalBackdropPath
    }
}
