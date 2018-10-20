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

final class NowPlayingViewController: BaseViewController {
    
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
        loadMovies()
    }
    
    // MARK: - Private Methods
    
    private func customizeUI() {
        // Title
        title = Constants.NowPlayingSceneConstants.title
    }
    
    private func loadMovies() {
        presenter.getNowPlayingMovies(page: page + 1) { [weak self] moviesList in
            guard let self = self else { return }
            self.movies += moviesList.results
            self.page = moviesList.page
            self.totalPages = moviesList.totalPages
            self.moviesCollectionView.reloadData()
        }
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
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        SceneCoordinator.shared.transition(to: Scene.movieDetails(movie: movies[indexPath.row])) {
            
        }
    }
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
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == movies.count - 1 && page + 1 <= totalPages {
            loadMovies()
        }
    }
}
