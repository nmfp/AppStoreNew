//
//  ReviewCell.swift
//  AppStoreNew
//
//  Created by Nuno Pereira on 03/04/2019.
//  Copyright © 2019 Nuno Pereira. All rights reserved.
//

import UIKit

class ReviewRowCell: UICollectionViewCell {
    
    static let key: String = String(describing: ReviewRowCell.self)
    
    var reviewsController = ReviewsController()
    
    private var reviewLabel: UILabel = {
        let label = UILabel()
        label.text = "Reviews & Ratings"
        label.font = UIFont.boldSystemFont(ofSize: 24.0)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }
    
    
    private func setupViews() {
        addSubview(reviewLabel)
        addSubview(reviewsController.view)
        reviewLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 16.0, left: 16.0, bottom: 0.0, right: 16.0))
        reviewsController.view.anchor(top: reviewLabel.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 16.0, left: 0.0, bottom: 16.0, right: 0.0))
    }
}
