//
//  AppRowCell.swift
//  AppStoreNew
//
//  Created by Nuno Pereira on 18/03/2019.
//  Copyright © 2019 Nuno Pereira. All rights reserved.
//

import UIKit

class AppRowCell: UICollectionViewCell {
    
    //MARK:- Properties
    static let key = String(describing: AppRowCell.self)
    
    private let appIconImageView: UIImageView = {
        let iv = UIImageView()
        iv.layer.cornerRadius = 16.0
        iv.clipsToBounds = true
        iv.backgroundColor = .red
        return iv
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "App name"
        label.font = .systemFont(ofSize: 20.0)
        return label
    }()
    
    private let companyLabel: UILabel = {
        let label = UILabel()
        label.text = "Photo & Video"
        label.font = .systemFont(ofSize: 13.0)
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
        overallStackView.spacing = 16.0
        addSubview(overallStackView)
        overallStackView.fillSuperview()
    }
}
