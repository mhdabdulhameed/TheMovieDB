//
//  Scene.swift
//  TheMovieDB
//
//  Created by Mohamed Abdul-Hameed on 10/20/18.
//  Copyright © 2018 Mohamed Abdul-Hameed. All rights reserved.
//

import UIKit

/**
 Refers to a screen managed by a view controller.
 It can be a regular screen, or a modal dialog.
 It comprises a view controller and a view model.
 */

protocol TargetScene {
    var transition: SceneTransitionType { get }
}

enum Scene {
    case nowPlaying
}

extension Scene: TargetScene {
    var transition: SceneTransitionType {
        switch self {
        case .nowPlaying:
            let presenter = NowPlayingPresenter()
            let viewController = NowPlayingViewController(with: presenter)
            presenter.viewController = viewController
            let navigationController = UINavigationController(rootViewController: viewController)
            return .root(navigationController)
        }
    }
}
