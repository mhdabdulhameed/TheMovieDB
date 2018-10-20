//
//  MovieAPI.swift
//  TheMovieDB
//
//  Created by Mohamed Abdul-Hameed on 10/20/18.
//  Copyright © 2018 Mohamed Abdul-Hameed. All rights reserved.
//

import Moya

enum MovieAPI {
    case nowPlaying(page: Int)
    case search(query: String, page: Int)
}

extension MovieAPI: TargetType {
    var baseURL: URL {
        guard let url = URL(string: Constants.MovieAPIConstants.baseURL) else {
            fatalError("Base URL couldn't be configured")
        }
        return url
    }
    
    var path: String {
        switch self {
        case .nowPlaying:
            return Constants.MovieAPIConstants.nowPlaying
        case .search:
            return Constants.MovieAPIConstants.search
        }
    }
    
    var method: Method {
        switch self {
        case .nowPlaying, .search:
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .nowPlaying(let page):
            let parameters = [
                Constants.MovieAPIConstants.page: "\(page)",
                Constants.MovieAPIConstants.APIKey.key: Constants.MovieAPIConstants.APIKey.value
            ]
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
            
        case .search(let query, let page):
            let parameters = [
                Constants.MovieAPIConstants.query: query,
                Constants.MovieAPIConstants.page: "\(page)",
                Constants.MovieAPIConstants.APIKey.key: Constants.MovieAPIConstants.APIKey.value
            ]
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .nowPlaying, .search:
            return nil
        }
    }
}
