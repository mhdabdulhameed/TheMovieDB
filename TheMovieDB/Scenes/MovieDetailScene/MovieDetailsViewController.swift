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
    
    private var posterImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
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
    }
    
    private func addSubviews() {
        addPosterImageView()
    }
    
    private func addPosterImageView() {
        view.addSubview(posterImageView)
        setupPosterImageViewConstraints()
    }
    
    private func setupPosterImageViewConstraints() {
        posterImageView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        posterImageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        posterImageView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        posterImageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.35).isActive = true
        
        view.layoutIfNeeded()
    }
    
    private func loadData() {
        SDWebImageHelper.setImage(for: posterImageView, from: presenter.posterURL)
    }
}

extension MovieDetailsViewController: MovieDetailsDisplayLogic {
    
}
