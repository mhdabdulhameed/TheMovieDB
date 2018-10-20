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
    
    init(with moviesList: MoviesList) {
        results = moviesList.results.map(MovieViewModel.init)
        page = moviesList.page
        totalResults = moviesList.totalResults
        totalPages = moviesList.totalPages
    }
}
