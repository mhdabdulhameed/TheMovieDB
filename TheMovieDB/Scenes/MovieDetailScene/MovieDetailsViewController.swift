//
//  MovieDetailsViewController.swift
//  TheMovieDB
//
//  Created by Mohamed Abdul-Hameed on 10/20/18.
//  Copyright © 2018 Mohamed Abdul-Hameed. All rights reserved.
//

import UIKit

protocol MovieDetailsDisplayLogic: class {
    
}

final class MovieDetailsViewController: BaseViewController {
    
    /// Presneter
    private let presenter: MovieDetailsPresentationLogic
    
    /// An imageView to display the movie's poster.
    private var moviePosterImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    /// A label to display the movie's title.
    private var movieTitleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textColor = Constants.MovieSceneConstants.foregroundColor
        label.font = label.font.withSize(Constants.MovieSceneConstants.movieTitleFontSize)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    /// A text view to display the movie's overview.
    private var movieOverviewTextView: UITextView = {
        let textView = UITextView()
        textView.textColor = Constants.MovieSceneConstants.foregroundColor
        textView.font = UIFont(name: textView.font?.fontName ?? UIFont.systemFont(ofSize: 1).fontName, size: Constants.MovieSceneConstants.movieOverviewFontSize)
        textView.backgroundColor = .clear
        textView.isEditable = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    /// Initialize `MovieDetailsViewController` with a `MovieDetailsPresentationLogic` instance.
    init(with presenter: MovieDetailsPresentationLogic) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customizeUI()
        addSubviews()
        loadData()
    }
    
    /// Initializes the UI elements.
    private func customizeUI() {
        // Properties
        navigationController?.navigationBar.prefersLargeTitles = false
        
        self.edgesForExtendedLayout = []
    }
    
    /// Adds all subviews to the view hierarchy and setups their constraints.
    private func addSubviews() {
        addMoviePosterImageView()
        addMovieTitleLabel()
        addMovieOverviewTextView()
    }
    
    // MARK: - Movie poster Image View
    
    /// Adds `moviePosterImageView` to the view hierarchy and setups its constraints.
    private func addMoviePosterImageView() {
        view.addSubview(moviePosterImageView)
        setupMoviePosterImageViewConstraints()
    }
    
    /// Sets the constraints of `moviePosterImageView`.
    private func setupMoviePosterImageViewConstraints() {
        moviePosterImageView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        moviePosterImageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        moviePosterImageView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        moviePosterImageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.35).isActive = true
        
        view.layoutIfNeeded()
    }
    
    // MARK: - Movie title label
    
    /// Adds `movieTitleLabel` to the view hierarchy and setups its constraints.
    private func addMovieTitleLabel() {
        view.addSubview(movieTitleLabel)
        setupMovieTitleLabelConstraints()
    }
    
    /// Sets the constraints of `movieTitleLabel`.
    private func setupMovieTitleLabelConstraints() {
        movieTitleLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10.0).isActive = true
        movieTitleLabel.topAnchor.constraint(equalTo: moviePosterImageView.bottomAnchor).isActive = true
        movieTitleLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 10.0).isActive = true
        movieTitleLabel.heightAnchor.constraint(equalToConstant: 30.0).isActive = true
        
        view.layoutIfNeeded()
    }
    
    // MARK: - Movie overview text view
    
    /// Adds `movieOverviewTextView` to the view hierarchy and setups its constraints.
    private func addMovieOverviewTextView() {
        view.addSubview(movieOverviewTextView)
        setupMovieOverviewTextViewConstraints()
    }
    
    /// Sets the constraints of `movieOverviewTextView`.
    private func setupMovieOverviewTextViewConstraints() {
        movieOverviewTextView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 5.0).isActive = true
        movieOverviewTextView.topAnchor.constraint(equalTo: movieTitleLabel.bottomAnchor).isActive = true
        movieOverviewTextView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 5.0).isActive = true
        movieOverviewTextView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        view.layoutIfNeeded()
    }
    
    // MARK: - Data preparation
    
    /// Fills to UI elements with data from the presenter.
    private func loadData() {
        SDWebImageHelper.setImage(for: moviePosterImageView, from: presenter.moviePosterURL)
        movieTitleLabel.text = presenter.movieTitle
        movieOverviewTextView.text = presenter.movieOverview
    }
}

extension MovieDetailsViewController: MovieDetailsDisplayLogic {
    
}
