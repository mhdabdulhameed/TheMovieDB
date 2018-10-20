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
    
    /// The data related to all movies.
    
    private var allMovies = [MovieViewModel]()
    private var allMoviesPage = 0
    private var allMoviesTotalPages = 0
    
    /// The data related to search results.
    
    private var searchResultsMovies = [MovieViewModel]()
    private var searchResultsPage = 0
    private var searchResultsTotalPages = 0
    
    /// Create and customize moviesCollectionView lazily.
    private lazy var moviesCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 0.0
        flowLayout.minimumInteritemSpacing = 0.0
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        let cellWidth = UIScreen.main.bounds.width / 2
        let cellHeight = cellWidth * 1.5
        flowLayout.itemSize = CGSize(width: cellWidth, height: cellHeight)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: MovieCollectionViewCell.reuseIdentifier)
        collectionView.backgroundColor = Constants.NowPlayingSceneConstants.backgroundColor
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
    /// Create and customize moviesSearchViewController lazily.
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
    
    /// Initialize `NowPlayingViewController` with a `NowPlayingPresentationLogic` instance.
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
    
    /// Initializes the UI elements.
    private func initializeUI() {
        // Title
        title = Constants.NowPlayingSceneConstants.title
        
        navigationItem.searchController = moviesSearchViewController
        
        definesPresentationContext = true
    }
    
    /// Uses the presenter to get now playing movies taking into consideration the current page.
    private func loadMovies() {
        presenter.getNowPlayingMovies(page: allMoviesPage + 1) { [weak self] moviesList in
            guard let self = self else { return }
            self.allMovies += moviesList.results
            self.allMoviesPage = moviesList.page
            self.allMoviesTotalPages = moviesList.totalPages
            
            if self.moviesCollectionView.numberOfItems(inSection: 0) == 0 {
                self.moviesCollectionView.reloadData()
            } else {
                let newIndexPaths = (self.allMovies.count - 20...self.allMovies.count - 1).map({ index in
                    IndexPath(item: index, section: 0)
                })
                self.moviesCollectionView.performBatchUpdates({
                    self.moviesCollectionView.insertItems(at: newIndexPaths)
                })
            }
        }
    }
    
    /// Uses the presenter to get search results based on the text of the searchbar taking into consideration the current page.
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
    
    /// Adds `moviesCollectionView` to the view hierarchy and setups its constraints.
    private func addMoviesCollectionView() {
        view.addSubview(moviesCollectionView)
        setupMoviesCollectionViewConstraints()
    }
    
    /// Sets the constraints of `moviesCollectionView`.
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
    
    /// Checks whether the user is performing a search or not.
    ///
    /// - Returns: A Boolean indicating whether the search controller is active or not.
    private func isSearching() -> Bool {
        return moviesSearchViewController.isActive
    }
}

extension NowPlayingViewController: NowPlayingDisplayLogic {
    
}

extension NowPlayingViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        // If the user is searching, we'll use searchResultsMovies array. Else, we'll use allMovies.
        let selectedMovie: MovieViewModel
        if isSearching() {
            selectedMovie = searchResultsMovies[indexPath.row]
        } else {
            selectedMovie = allMovies[indexPath.row]
        }
        
        // Perfrom navigation to movie details screen and pass the appropriate view model to it.
        SceneCoordinator.shared.transition(to: Scene.movieDetails(movie: selectedMovie)) {
            
        }
    }
}

extension NowPlayingViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // If the user is searching, we'll use searchResultsMovies array. Else, we'll use allMovies.
        if isSearching() {
            return searchResultsMovies.count
        } else {
            return allMovies.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.reuseIdentifier, for: indexPath) as? MovieCollectionViewCell else { return UICollectionViewCell() }
        
        // If the user is searching, we'll use searchResultsMovies array. Else, we'll use allMovies.
        if isSearching() {
            cell.configure(posterURL: searchResultsMovies[indexPath.row].smallPosterPath)
        } else {
            cell.configure(posterURL: allMovies[indexPath.row].smallPosterPath)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {

        // When the user scrolls and reaches the last cell we need to make a new call to get a new batch of the data (if there was a new batch).
        // If the user is searching, we'll use searchResultsMovies array. Else, we'll use allMovies.
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
        
        // Whenever the user types a new letter to selects the searchbar we need to clear searchResultsData to start a clean new search.
        searchResultsMovies = []
        searchResultsPage = 0
        searchResultsTotalPages = 0
        
        // Add a delay between calls.
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(self.searchMovies), object: nil)
        self.perform(#selector(self.searchMovies), with: nil, afterDelay: 0.5)
    }
}

extension NowPlayingViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        // The searchbar is inActive now so we need to reload the data to show allMovies instead of searchResultsMovies.
        moviesCollectionView.reloadData()
    }
}
