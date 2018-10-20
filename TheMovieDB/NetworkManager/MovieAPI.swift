//
//  MovieAPI.swift
//  TheMovieDB
//
//  Created by Mohamed Abdul-Hameed on 10/20/18.
//  Copyright © 2018 Mohamed Abdul-Hameed. All rights reserved.
//

import Moya

enum MovieAPI {
    case nowPlaying
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
        }
    }
    
    var method: Method {
        switch self {
        case .nowPlaying:
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .nowPlaying:
            let parameters = [Constants.MovieAPIConstants.APIKey.key: Constants.MovieAPIConstants.APIKey.value]
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .nowPlaying:
            return nil
        }
    }
}