//
//  MovieCollectionViewCell.swift
//  TheMovieDB
//
//  Created by Mohamed Abdul-Hameed on 10/20/18.
//  Copyright © 2018 Mohamed Abdul-Hameed. All rights reserved.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    
    /// `MovieCollectionViewCell` reuse identifier.
    static let reuseIdentifier = String(describing: MovieCollectionViewCell.self)
    
    /// An ImageView instance to show the poster image.
    private lazy var posterImageView: UIImageView = {
        let imageView = UIImageView(frame: frame)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addPosterImageView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(posterURL: URL) {
        SDWebImageHelper.setImage(for: posterImageView, from: posterURL) { [weak self] in
            self?.posterImageView.alpha = 0
            UIView.animate(withDuration: 0.2) {
                self?.posterImageView.alpha = 1
            }
        }
    }
    
    // MARK: - Private methods
    
    /// Adds the `posterImageView` to the view hierarchy.
    private func addPosterImageView() {
        addSubview(posterImageView)
        setupPosterImageViewConstraints()
    }
    
    /// Sets the constraints of the `posterImageView` in the appropriate way.
    private func setupPosterImageViewConstraints() {
        posterImageView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        posterImageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        posterImageView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        posterImageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        layoutIfNeeded()
    }
}
