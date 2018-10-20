//
//  SceneCoordinatorType.swift
//  TheMovieDB
//
//  Created by Mohamed Abdul-Hameed on 10/20/18.
//  Copyright © 2018 Mohamed Abdul-Hameed. All rights reserved.
//

import UIKit

protocol SceneCoordinatorType {
    init(window: UIWindow)
    
    func transition(to scene: TargetScene, onComplete: @escaping (() -> Void))
}
