//
//  MoyaNetworkManager.swift
//  TheMovieDB
//
//  Created by Mohamed Abdul-Hameed on 10/20/18.
//  Copyright © 2018 Mohamed Abdul-Hameed. All rights reserved.
//

import Moya

final class MoyaNetworkManager: NetworkManager {
    
    static let shared = MoyaNetworkManager()
    
    private lazy var provider: MoyaProvider<MovieAPI> = {
        return MoyaProvider<MovieAPI>(plugins: plugins)
    }()
    
    lazy var plugins: [PluginType] = {
        return [NetworkLoggerPlugin(verbose: true)]
    }()
    
    private init() { }
    
    func startRequest<T: Codable>(api: MovieAPI, onComplete: @escaping (Result<T>) -> Void) {
        provider.request(api) { result in
            switch result {
            case .success(let response):
                do {
                    let responseModel = try JSONDecoder().decode(T.self, from: response.data)
                    onComplete(.success(responseModel))
                    
                } catch let error {
                    onComplete(.failure(error))
                }
                
            case .failure(let error):
                onComplete(.failure(error))
            }
        }
    }
}
