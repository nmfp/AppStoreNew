//
//  SearchResultCell.swift
//  AppStoreNew
//
//  Created by Nuno Pereira on 17/03/2019.
//  Copyright © 2019 Nuno Pereira. All rights reserved.
//

import UIKit

class SearchResultCell: UICollectionViewCell {
    
    static let key = String(describing: SearchResultCell.self)
    
    private let appIconImageView: UIImageView = {
       let iv = UIImageView()
        iv.backgroundColor = .red
        iv.layer.cornerRadius = 16.0
        return iv
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "App name"
        return label
    }()
    
    private let categoryLabel: UILabel = {
        let label = UILabel()
        label.text = "Photo & Video"
        return label
    }()
    
    private let ratingLabel: UILabel = {
        let label = UILabel()
        label.text = "4.6"
        return label
    }()
    
    private lazy var getButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("GET", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14.0)
        button.backgroundColor = UIColor(white: 0.95, alpha: 1.0)
        button.layer.cornerRadius = 16.0
        return button
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
        
        let labelsStackView = UIStackView(arrangedSubviews: [nameLabel, categoryLabel, ratingLabel])
        labelsStackView.axis = .vertical
        
        let infoStackView = UIStackView(arrangedSubviews: [appIconImageView, labelsStackView, getButton])
        infoStackView.alignment = .center
        infoStackView.spacing = 12.0
        
        let screenShotsStackView = UIStackView(arrangedSubviews: [createScreenShot(), createScreenShot(), createScreenShot()])
        screenShotsStackView.spacing = 12.0
        screenShotsStackView.distribution = .fillEqually
        
        let overallStackView = UIStackView(arrangedSubviews: [infoStackView, screenShotsStackView])
        overallStackView.axis = .vertical
        overallStackView.spacing = 16.0
        
        addSubview(overallStackView)
        overallStackView.fillSuperview(padding: .init(top: 16.0, left: 16.0, bottom: 16.0, right: 16.0))
        
        NSLayoutConstraint.activate([
            appIconImageView.widthAnchor.constraint(equalToConstant: 64.0),
            appIconImageView.heightAnchor.constraint(equalTo: appIconImageView.widthAnchor),
            getButton.heightAnchor.constraint(equalToConstant: 32.0),
            getButton.widthAnchor.constraint(equalToConstant: 80.0)
            ])
    }
    
    private func createScreenShot() -> UIImageView {
        let iv = UIImageView()
        iv.backgroundColor = .blue
        return iv
    }
}
