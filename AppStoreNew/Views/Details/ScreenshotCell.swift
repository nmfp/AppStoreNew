//
//  ScreenshotCell.swift
//  AppStoreNew
//
//  Created by Nuno Pereira on 03/04/2019.
//  Copyright © 2019 Nuno Pereira. All rights reserved.
//

import UIKit

class ScreenshotCell: UICollectionViewCell {
    
    static let key = String(describing: ScreenshotCell.self)
    
    private let imageView: UIImageView = {
       let iv = UIImageView()
        iv.layer.cornerRadius = 12.0
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    var imageUrlString: String? {
        didSet {
            imageView.sd_setImage(with: URL(string: imageUrlString ?? ""))
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(imageView)
        imageView.fillSuperview()
    }
}
