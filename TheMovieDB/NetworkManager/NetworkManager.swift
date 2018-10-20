//
//  NetworkManager.swift
//  TheMovieDB
//
//  Created by Mohamed Abdul-Hameed on 10/20/18.
//  Copyright © 2018 Mohamed Abdul-Hameed. All rights reserved.
//

protocol NetworkManager {
    
    /// Starts a network request with the specified API End Point.
    ///
    /// - Parameter api: the End Point to call.
    /// - Parameter onComplete: Takes `Result<T>`.
    func startRequest<T: Codable>(api: MovieAPI, onComplete: @escaping (Result<T>) -> Void)
}
