//
//  NowPlayingPresenter.swift
//  TheMovieDB
//
//  Created by Mohamed Abdul-Hameed on 10/20/18.
//  Copyright © 2018 Mohamed Abdul-Hameed. All rights reserved.
//

import Foundation

protocol NowPlayingPresentationLogic: class {
    func getNowPlayingMovies(page: Int, onComplete: @escaping (MoviesListViewModel) -> Void)
}

final class NowPlayingPresenter: NowPlayingPresentationLogic {
    
    weak var viewController: NowPlayingDisplayLogic?
    
    private let networkManager: NetworkManager
    
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
}
