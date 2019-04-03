//
//  ReviewCell.swift
//  AppStoreNew
//
//  Created by Nuno Pereira on 03/04/2019.
//  Copyright © 2019 Nuno Pereira. All rights reserved.
//

import UIKit

class ReviewCell: UICollectionViewCell {
    
    static let key: String = String(describing: ReviewCell.self)
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Title label"
        label.font = UIFont.systemFont(ofSize: 18.0)
        return label
    }()
    
    private var authorLabel: UILabel = {
        let label = UILabel()
        label.text = "Author label"
        label.font = UIFont.systemFont(ofSize: 16.0)
        return label
    }()
    
    private var starsLabel: UILabel = {
        let label = UILabel()
        label.text = "Stars label"
        label.font = UIFont.systemFont(ofSize: 14.0)
        return label
    }()
    
    private var bodyLabel: UILabel = {
        let label = UILabel()
        label.text = "Body Label"
        label.font = UIFont.systemFont(ofSize: 14.0)
        label.numberOfLines = 0
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
        backgroundColor = #colorLiteral(red: 0.9493758082, green: 0.9438468218, blue: 0.9817424417, alpha: 1)
        layer.cornerRadius = 16.0
        clipsToBounds = true
        
        let stackView = UIStackView(arrangedSubviews: [
            UIStackView(arrangedSubviews: [titleLabel, UIView(), authorLabel]),
            starsLabel,
            bodyLabel
            ])
        stackView.spacing = 12.0
        stackView.axis = .vertical
        
        addSubview(stackView)
        stackView.fillSuperview(padding: .init(top: 20.0, left: 20.0, bottom: 20.0, right: 20.0))
    }
}
