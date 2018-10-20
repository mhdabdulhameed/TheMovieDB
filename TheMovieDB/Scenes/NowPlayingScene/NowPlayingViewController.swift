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
    
    private var movies = [MovieViewModel]()
    private var page = 0
    private var totalPages = 0
    
    /// Create and customize moviesCollectionView lazily.
    private lazy var moviesCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 0.0
        flowLayout.minimumInteritemSpacing = 0.0
        flowLayout.itemSize = moviesCollectionViewItemSize
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: MovieCollectionViewCell.reuseIdentifier)
        collectionView.backgroundColor = Constants.NowPlayingSceneConstants.backgroundColor
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
    private var moviesCollectionViewItemSize: CGSize {
        return CGSize(width: view.frame.width / 2, height: view.frame.width / 2)
    }
    
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
        addMoviesCollectionView()
        
        presenter.getNowPlayingMovies { [weak self] moviesList in
            self?.movies += moviesList.results
            self?.page = moviesList.page
            self?.totalPages = moviesList.totalPages
            self?.moviesCollectionView.reloadData()
        }
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
    
    private func addMoviesCollectionView() {
        view.addSubview(moviesCollectionView)
        setupMoviesCollectionViewConstraints()
    }
    
    private func setupMoviesCollectionViewConstraints() {
        moviesCollectionView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        moviesCollectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        moviesCollectionView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        moviesCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        view.layoutIfNeeded()
    }
}

extension NowPlayingViewController: NowPlayingDisplayLogic {
    
}

extension NowPlayingViewController: UICollectionViewDelegate {
    
}

extension NowPlayingViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.reuseIdentifier, for: indexPath) as? MovieCollectionViewCell else { return UICollectionViewCell() }
        cell.configure(posterURL: movies[indexPath.row].smallPosterPath)
        return cell
    }
}
