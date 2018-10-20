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
    
    private var allMovies = [MovieViewModel]()
    private var allMoviesPage = 0
    private var allMoviesTotalPages = 0
    
    private var searchResultsMovies = [MovieViewModel]()
    private var searchResultsPage = 0
    private var searchResultsTotalPages = 0
    
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
    
    private lazy var moviesSearchViewController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = Constants.NowPlayingSceneConstants.searchbarPlaceHolder
        searchController.searchBar.tintColor = Constants.NowPlayingSceneConstants.foregroundColor
        searchController.searchBar.barStyle = .black
        return searchController
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
        
        initializeUI()
        addMoviesCollectionView()
        loadMovies()
    }
    
    // MARK: - Private Methods
    
    private func initializeUI() {
        // Title
        title = Constants.NowPlayingSceneConstants.title
        
        navigationItem.searchController = moviesSearchViewController
        
        definesPresentationContext = true
    }
    
    private func loadMovies() {
        presenter.getNowPlayingMovies(page: allMoviesPage + 1) { [weak self] moviesList in
            guard let self = self else { return }
            self.allMovies += moviesList.results
            self.allMoviesPage = moviesList.page
            self.allMoviesTotalPages = moviesList.totalPages
            self.moviesCollectionView.reloadData()
        }
    }
    
    @objc private func searchMovies() {
        guard let query = moviesSearchViewController.searchBar.text, !query.isEmpty else {
            moviesCollectionView.reloadData()
            return
            
        }
        presenter.searchMovies(with: query, page: searchResultsPage + 1) { [weak self] moviesList in
            guard let self = self else { return }
            self.searchResultsMovies += moviesList.results
            self.searchResultsPage = moviesList.page
            self.searchResultsTotalPages = moviesList.totalPages
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
    
    /// Returns true if the text is empty or nil
    private func searchBarIsEmpty() -> Bool {
        return moviesSearchViewController.searchBar.text?.isEmpty ?? true
    }
    
    private func isSearching() -> Bool {
        return moviesSearchViewController.isActive
    }
}

extension NowPlayingViewController: NowPlayingDisplayLogic {
    
}

extension NowPlayingViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedMovie: MovieViewModel
        if isSearching() {
            selectedMovie = searchResultsMovies[indexPath.row]
        } else {
            selectedMovie = allMovies[indexPath.row]
        }
        
        SceneCoordinator.shared.transition(to: Scene.movieDetails(movie: selectedMovie)) {
            
        }
    }
}

extension NowPlayingViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isSearching() {
            return searchResultsMovies.count
        } else {
            return allMovies.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.reuseIdentifier, for: indexPath) as? MovieCollectionViewCell else { return UICollectionViewCell() }
        
        if isSearching() {
            cell.configure(posterURL: searchResultsMovies[indexPath.row].smallPosterPath)
        } else {
            cell.configure(posterURL: allMovies[indexPath.row].smallPosterPath)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {

        if isSearching() {
            if indexPath.row == searchResultsMovies.count - 1 && searchResultsPage + 1 <= searchResultsTotalPages {
                searchMovies()
            }
        } else {
            if indexPath.row == allMovies.count - 1 && allMoviesPage + 1 <= allMoviesTotalPages {
                loadMovies()
            }
        }
    }
}

extension NowPlayingViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        print("--- Will search for: \(searchController.searchBar.text) and clear all")
        searchResultsMovies = []
        searchResultsPage = 0
        searchResultsTotalPages = 0
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(self.searchMovies), object: nil)
        self.perform(#selector(self.searchMovies), with: nil, afterDelay: 0.5)
    }
}

extension NowPlayingViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        moviesCollectionView.reloadData()
    }
}
