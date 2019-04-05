//
//  TodayBaseCell.swift
//  AppStoreNew
//
//  Created by Nuno Pereira on 05/04/2019.
//  Copyright © 2019 Nuno Pereira. All rights reserved.
//

import UIKit

class TodayBaseCell: UICollectionViewCell {
    var todayItem: TodayItem?
    
    override var isHighlighted: Bool {
        didSet{
            var transform: CGAffineTransform = .identity
            if isHighlighted {
                transform = .init(scaleX: 0.9, y: 0.9)
            }
            UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.transform = transform
            })
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupShadow()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupShadow() {
        
        backgroundView = UIView()
        addSubview(backgroundView!)
        backgroundView?.fillSuperview()
        backgroundView?.backgroundColor = .white
        backgroundView?.layer.cornerRadius = 16.0
        
        backgroundView?.layer.shadowOpacity = 0.1
        backgroundView?.layer.shadowRadius = 10
        //Most likely shifting shadow 10 points below
        backgroundView?.layer.shadowOffset = .init(width: 0, height: 10)
        backgroundView?.layer.shouldRasterize = true
    }
}
