//
//  NowPlayingViewController.swift
//  TheMovieDB
//
//  Created by Mohamed Abdul-Hameed on 10/20/18.
//  Copyright © 2018 Mohamed Abdul-Hameed. All rights reserved.
//

import UIKit

protocol NowPlayingDisplayLogic: class {
    
}

final class NowPlayingViewController: UIViewController {
    
    /// Presneter
    private let presenter: NowPlayingPresentationLogic
    
    /// Create and customize albumsCollectionView lazily.
//    private lazy var albumsCollectionView: UICollectionView = {
//        let flowLayout = UICollectionViewFlowLayout()
//        flowLayout.minimumLineSpacing = 1.0
//        flowLayout.minimumInteritemSpacing = 1.0
//        flowLayout.itemSize = albumsCollectionViewItemSize
//        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
//        collectionView.register(UINib(nibName: Constants.NibFilesNames.albumCollectionViewCell, bundle: nil),
//                                forCellWithReuseIdentifier: AlbumCollectionViewCell.reuseIdentifier)
//        collectionView.backgroundColor=UIColor.white
//        collectionView.translatesAutoresizingMaskIntoConstraints = false
//        collectionView.isHidden = true
//        return collectionView
//    }()
    
    init(with presenter: NowPlayingPresentationLogic) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customizeUI()
    }
    
    // MARK: - Private Methods
    
    private func customizeUI() {
        // Title
        title = Constants.NowPlayingSceneConstants.title
        
        // Colors
        let backgroundColor = Constants.NowPlayingSceneConstants.backgroundColor
        let foregroundColor = Constants.NowPlayingSceneConstants.foregroundColor
        view.backgroundColor = backgroundColor
        navigationController?.navigationBar.tintColor = foregroundColor
        navigationController?.navigationBar.barTintColor = backgroundColor
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: foregroundColor]
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: foregroundColor]
        
        // Properties
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.isTranslucent = false
    }
}

extension NowPlayingViewController: NowPlayingDisplayLogic {
    
}
