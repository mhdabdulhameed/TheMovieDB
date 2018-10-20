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
    
    private var moviePosterImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private var movieTitleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textColor = Constants.MovieSceneConstants.foregroundColor
        label.font = label.font.withSize(Constants.MovieSceneConstants.movieTitleFontSize)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var movieOverviewTextView: UITextView = {
        let textView = UITextView()
        textView.textColor = Constants.MovieSceneConstants.foregroundColor
        textView.font = UIFont(name: textView.font?.fontName ?? UIFont.systemFont(ofSize: 1).fontName, size: Constants.MovieSceneConstants.movieOverviewFontSize)
        textView.backgroundColor = .clear
        textView.isEditable = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
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
    
    private func customizeUI() {
        // Properties
        navigationController?.navigationBar.prefersLargeTitles = false
        
        self.edgesForExtendedLayout = []
    }
    
    private func addSubviews() {
        addMoviePosterImageView()
        addMovieTitleLabel()
        addMovieOverviewTextView()
    }
    
    // MARK: - Movie poster Image View
    
    private func addMoviePosterImageView() {
        view.addSubview(moviePosterImageView)
        setupMoviePosterImageViewConstraints()
    }
    
    private func setupMoviePosterImageViewConstraints() {
        moviePosterImageView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        moviePosterImageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        moviePosterImageView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        moviePosterImageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.35).isActive = true
        
        view.layoutIfNeeded()
    }
    
    // MARK: - Movie title label
    
    private func addMovieTitleLabel() {
        view.addSubview(movieTitleLabel)
        setupMovieTitleLabelConstraints()
    }
    
    private func setupMovieTitleLabelConstraints() {
        movieTitleLabel.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        movieTitleLabel.topAnchor.constraint(equalTo: moviePosterImageView.bottomAnchor).isActive = true
        movieTitleLabel.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        movieTitleLabel.heightAnchor.constraint(equalToConstant: 30.0).isActive = true
        
        view.layoutIfNeeded()
    }
    
    // MARK: - Movie overview text view
    
    private func addMovieOverviewTextView() {
        view.addSubview(movieOverviewTextView)
        setupMovieOverviewTextViewConstraints()
    }
    
    private func setupMovieOverviewTextViewConstraints() {
        movieOverviewTextView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        movieOverviewTextView.topAnchor.constraint(equalTo: movieTitleLabel.bottomAnchor).isActive = true
        movieOverviewTextView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        movieOverviewTextView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        view.layoutIfNeeded()
    }
    
    // MARK: - Data preparation
    
    private func loadData() {
        SDWebImageHelper.setImage(for: moviePosterImageView, from: presenter.moviePosterURL)
        movieTitleLabel.text = presenter.movieTitle
        movieOverviewTextView.text = presenter.movieOverview
    }
}

extension MovieDetailsViewController: MovieDetailsDisplayLogic {
    
}
