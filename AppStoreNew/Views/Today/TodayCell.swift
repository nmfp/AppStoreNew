//
//  TodayCell.swift
//  AppStoreNew
//
//  Created by Nuno Pereira on 04/04/2019.
//  Copyright © 2019 Nuno Pereira. All rights reserved.
//

import UIKit

class TodayCell: UICollectionViewCell {
    
    static let key: String = String(describing: TodayCell.self)
    
    private let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    private let categoryLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20.0)
        return label
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 26.0)
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16.0)
        label.numberOfLines = 0
        return label
    }()
    
    var topConstraint: NSLayoutConstraint?
    
    var todayItem: TodayItem? {
        didSet {
            imageView.image = todayItem?.image
            categoryLabel.text = todayItem?.category
            titleLabel.text = todayItem?.title
            descriptionLabel.text = todayItem?.description
            backgroundColor = todayItem?.backgroundColor
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }
    
    
    private func setupViews() {
        backgroundColor = .white
        layer.cornerRadius = 16.0
        clipsToBounds = true
        
        let imageContainer = UIView()
        imageContainer.addSubview(imageView)
        imageView.centerInSuperview(size: .init(width: 240.0, height: 240.0))
        
        let stackView = UIStackView(arrangedSubviews: [
            categoryLabel,
            titleLabel,
            imageContainer,
            descriptionLabel
            ])
        stackView.spacing = 8
        stackView.axis = .vertical
        addSubview(stackView)
        stackView.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0.0, left: 24.0, bottom: 24.0, right: 24.0))
        topConstraint = stackView.topAnchor.constraint(equalTo: topAnchor, constant: 24.0)
        topConstraint?.isActive = true
    }
}
