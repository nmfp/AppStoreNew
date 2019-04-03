//
//  PreviewCell.swift
//  AppStoreNew
//
//  Created by Nuno Pereira on 03/04/2019.
//  Copyright © 2019 Nuno Pereira. All rights reserved.
//

import UIKit

class PreviewCell: UICollectionViewCell {
    
    static let key = String(describing: PreviewCell.self)
    
    var screenshotsController = PreviewScreenshotsController()
    
    private var previewLabel: UILabel = {
        let label = UILabel()
        label.text = "Preview"
        label.font = UIFont.boldSystemFont(ofSize: 24.0)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(previewLabel)
        addSubview(screenshotsController.view)
        previewLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 0.0, left: 20.0, bottom: 0.0, right: 20.0))
        screenshotsController.view.anchor(top: previewLabel.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 12.0, left: 0.0, bottom: 0.0, right: 0.0))
    }
}
