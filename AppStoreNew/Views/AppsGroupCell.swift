//
//  AppsGroupCell.swift
//  AppStoreNew
//
//  Created by Nuno Pereira on 18/03/2019.
//  Copyright © 2019 Nuno Pereira. All rights reserved.
//

import UIKit

class AppsGroupCell: UICollectionViewCell {
    
    static let key = String(describing: AppsGroupCell.self)
    
    var appGroup: AppGroup? {
        didSet {
            titleLabel.text = appGroup?.feed.title
            horizontalListController.appGroup = appGroup
        }
    }
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "App Section"
        label.font = .boldSystemFont(ofSize: 26.0)
        return label
    }()
    
    let horizontalListController = AppsHorizontalController()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }
    
    private func setupViews() {
        addSubview(titleLabel)
        addSubview(horizontalListController.view)
        titleLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 16.0, left: 16.0, bottom: 0.0, right: 0.0))
        horizontalListController.view.anchor(top: titleLabel.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
    }
}
