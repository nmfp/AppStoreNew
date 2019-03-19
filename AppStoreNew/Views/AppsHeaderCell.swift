//
//  AppsHeaderCell.swift
//  AppStoreNew
//
//  Created by Nuno Pereira on 19/03/2019.
//  Copyright © 2019 Nuno Pereira. All rights reserved.
//

import UIKit

class AppsHeaderCell: UICollectionViewCell {
    
    //MARK:- Properties
    static let key = String(describing: AppsHeaderCell.self)
    
    private let appImageView: UIImageView = {
        let iv = UIImageView()
        iv.layer.cornerRadius = 8.0
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "App name"
        label.font = .systemFont(ofSize: 24.0)
        label.numberOfLines = 2
        return label
    }()
    
    private let companyLabel: UILabel = {
        let label = UILabel()
        label.text = "Company"
        label.font = .systemFont(ofSize: 12.0)
        label.textColor = .blue
        return label
    }()
    
    var socialApp: SocialApp? {
        didSet {
            titleLabel.text = socialApp?.tagline
            companyLabel.text = socialApp?.name
            appImageView.sd_setImage(with: URL(string: socialApp?.imageUrl ?? ""))
        }
    }
    
    //MARK:- Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:- Setup UI
    private func setupViews() {
        let stackView = UIStackView(arrangedSubviews: [companyLabel, titleLabel, appImageView])
        stackView.spacing = 12.0
        stackView.axis = .vertical
        
        addSubview(stackView)
        stackView.fillSuperview()
    }
}
