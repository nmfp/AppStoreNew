//
//  MultipleAppCell.swift
//  AppStoreNew
//
//  Created by Nuno Pereira on 05/04/2019.
//  Copyright © 2019 Nuno Pereira. All rights reserved.
//

import UIKit

class MultipleAppCell: UICollectionViewCell {
    
    static let key: String = String(describing: MultipleAppCell.self)
    
    private let appIconImageView: UIImageView = {
        let iv = UIImageView()
        iv.layer.cornerRadius = 16.0
        iv.backgroundColor = .purple
        iv.clipsToBounds = true
        iv.layer.borderWidth = 0.5
        iv.layer.borderColor = UIColor(white: 0.85, alpha: 1.0).cgColor
        return iv
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "App name"
        label.font = .systemFont(ofSize: 16.0)
        return label
    }()
    
    private let companyLabel: UILabel = {
        let label = UILabel()
        label.text = "Photo & Video"
        label.font = .systemFont(ofSize: 12.0)
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
    
    private let separatorLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.5, alpha: 0.5)
        return view
    }()
    
    var feedResult: FeedResult? {
        didSet {
            nameLabel.text = feedResult?.name
            companyLabel.text = feedResult?.artistName
            appIconImageView.sd_setImage(with: URL(string: feedResult?.artworkUrl100 ?? ""))
        }
    }
    
    //MARK:- Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }
    
    //MARK:- Setup UI
    private func setupViews() {
        
        NSLayoutConstraint.activate([
            appIconImageView.widthAnchor.constraint(equalToConstant: 64.0),
            appIconImageView.heightAnchor.constraint(equalTo: appIconImageView.widthAnchor),
            getButton.widthAnchor.constraint(equalToConstant: 80.0),
            getButton.heightAnchor.constraint(equalToConstant: 32.0)
            ])
        
        let labelsStack = UIStackView(arrangedSubviews: [nameLabel, companyLabel])
        labelsStack.axis = .vertical
        
        let overallStackView = UIStackView(arrangedSubviews: [appIconImageView, labelsStack, getButton])
        overallStackView.alignment = .center
        overallStackView.spacing = 12.0
        addSubview(overallStackView)
        overallStackView.fillSuperview()
        
        addSubview(separatorLine)
        separatorLine.anchor(top: nil, leading: nameLabel.leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0.0, left: 0.0, bottom: -8.0, right: 0.0), size: .init(width: 0.0, height: 1.0))
    }
}
