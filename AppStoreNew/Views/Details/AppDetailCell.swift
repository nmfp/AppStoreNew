//
//  AppDetailCell.swift
//  AppStoreNew
//
//  Created by Nuno Pereira on 30/03/2019.
//  Copyright © 2019 Nuno Pereira. All rights reserved.
//

import UIKit

class AppDetailCell: UICollectionViewCell {
    static let key = String(describing: AppDetailCell.self)
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.layer.cornerRadius = 16
        iv.clipsToBounds = true
        return iv
    }()
    
    var appNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.text = "App Name"
        label.font = UIFont.boldSystemFont(ofSize: 24.0)
        return label
    }()
    
    var priceButton: UIButton = {
       let button = UIButton(type: .system)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.2183161676, green: 0.4692203999, blue: 0.942979753, alpha: 1)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16.0)
        button.layer.cornerRadius = 32 / 2
        button.clipsToBounds = true
        return button
    }()
    
    var whatsNewLabel: UILabel = {
        let label = UILabel()
        label.text = "What's New"
        label.font = UIFont.boldSystemFont(ofSize: 20.0)
        return label
    }()
    
    var releaseNotesLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "Release Notes"
        label.font = UIFont.systemFont(ofSize: 18.0)
        return label
    }()
    
    var app: Result? {
        didSet {
            appNameLabel.text = app?.trackName
            releaseNotesLabel.text = app?.releaseNotes
            imageView.sd_setImage(with: URL(string: app?.artworkUrl100 ?? ""))
            priceButton.setTitle(app?.formattedPrice, for: .normal)
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
        
        NSLayoutConstraint.activate([
            priceButton.heightAnchor.constraint(equalToConstant: 32.0),
            priceButton.widthAnchor.constraint(equalToConstant: 80.0),
            imageView.heightAnchor.constraint(equalToConstant: 140.0),
            imageView.widthAnchor.constraint(equalToConstant: 140.0)])
        
        let nameStackView = UIStackView(arrangedSubviews: [appNameLabel, UIStackView(arrangedSubviews: [priceButton, UIView()])])
        nameStackView.axis = .vertical
        nameStackView.spacing = 12.0
        
        let horizontalStackView = UIStackView(arrangedSubviews: [imageView, nameStackView])
        horizontalStackView.spacing = 20.0
        
        let stackView = UIStackView(arrangedSubviews:
            [
                horizontalStackView,
                whatsNewLabel,
                releaseNotesLabel
            ])
        stackView.axis = .vertical
        stackView.spacing = 16.0
        addSubview(stackView)
        stackView.fillSuperview(padding: .init(top: 20.0, left: 20.0, bottom: 20.0, right: 20.0))
    }
}
