//
//  NowPlayingPresenter.swift
//  TheMovieDB
//
//  Created by Mohamed Abdul-Hameed on 10/20/18.
//  Copyright © 2018 Mohamed Abdul-Hameed. All rights reserved.
//

import Foundation

protocol NowPlayingPresentationLogic: class {
    
}

final class NowPlayingPresenter: NowPlayingPresentationLogic {
    
    weak var viewController: NowPlayingDisplayLogic?
    
    private let networkManager: NetworkManager
    
    init(networkManager: NetworkManager = MoyaNetworkManager.shared) {
        self.networkManager = networkManager
    }
}
