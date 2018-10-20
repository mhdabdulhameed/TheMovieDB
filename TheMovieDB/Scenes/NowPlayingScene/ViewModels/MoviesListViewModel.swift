//
//  MoviesListViewModel.swift
//  TheMovieDB
//
//  Created by Mohamed Abdul-Hameed on 10/20/18.
//  Copyright © 2018 Mohamed Abdul-Hameed. All rights reserved.
//

struct MoviesListViewModel {
    let results: [MovieViewModel]
    let page: Int
    let totalResults: Int
    let totalPages: Int
    
    /// Initializes `MoviesListViewModel` with the response of `nowPlaying` API.
    ///
    /// - Parameter moviesList: An Instance of `MoviesList`.
    init(with moviesList: MoviesList) {
        results = moviesList.results.map(MovieViewModel.init)
        page = moviesList.page
        totalResults = moviesList.totalResults
        totalPages = moviesList.totalPages
    }
    
    
    /// Initializes `MoviesListViewModel` with the response of `search` API.
    ///
    /// - Parameter searchResults: An Instance of `SearchResults`.
    init(with searchResults: SearchResults) {
        results = searchResults.results.map(MovieViewModel.init)
        page = searchResults.page
        totalResults = searchResults.totalResults
        totalPages = searchResults.totalPages
    }
}
