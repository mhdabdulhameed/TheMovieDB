//
//  NowPlayingPresenter.swift
//  TheMovieDB
//
//  Created by Mohamed Abdul-Hameed on 10/20/18.
//  Copyright © 2018 Mohamed Abdul-Hameed. All rights reserved.
//

import Foundation

protocol NowPlayingPresentationLogic: class {
    
    /// Gets a list of the movies that being played in the cinemas now.
    ///
    /// - Parameters:
    ///   - page: The page number to retrieve.
    ///   - onComplete: A completion handler that takes an instance of `MoviesListViewModel` which contains the page's elements.
    func getNowPlayingMovies(page: Int, onComplete: @escaping (MoviesListViewModel) -> Void)
    
    /// Searches for a query.
    ///
    /// - Parameters:
    ///   - query: The string to search for.
    ///   - page: The page number to retrieve.
    ///   - onComplete: A completion handler that takes an instance of `MoviesListViewModel` which contains the page's elements.
    func searchMovies(with query: String, page: Int, onComplete: @escaping (MoviesListViewModel) -> Void)
}

final class NowPlayingPresenter: NowPlayingPresentationLogic {
    
    weak var viewController: NowPlayingDisplayLogic?
    
    private let networkManager: NetworkManager
    
    /// Initializes the `MovieDetailsPresenter`.
    ///
    /// - Parameters:
    ///   - networkManager: An instance of any class that conforms to `NetworkManager`.
    init(networkManager: NetworkManager = MoyaNetworkManager.shared) {
        self.networkManager = networkManager
    }
    
    // MARK: - NowPlayingPresentationLogic Protocol Conformance
    
    func getNowPlayingMovies(page: Int, onComplete: @escaping (MoviesListViewModel) -> Void) {
        let requestOnComplete: (Result<MoviesList>) -> Void = { result in
            switch result {
            case .success(let moviesList):
                onComplete(MoviesListViewModel(with: moviesList))
            case .failure(let error):
                // TODO show error.
                print(error)
            }
        }
        
        networkManager.startRequest(api: .nowPlaying(page: page), onComplete: requestOnComplete)
    }
    
    func searchMovies(with query: String, page: Int, onComplete: @escaping (MoviesListViewModel) -> Void) {
        let requestOnComplete: (Result<SearchResults>) -> Void = { result in
            switch result {
            case .success(let searchResults):
                onComplete(MoviesListViewModel(with: searchResults))
            case .failure(let error):
                // TODO show error.
                print(error)
            }
        }
        
        networkManager.startRequest(api: .search(query: query, page: page), onComplete: requestOnComplete)
    }
}
