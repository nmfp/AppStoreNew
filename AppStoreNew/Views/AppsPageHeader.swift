//
//  AppsPageHeader.swift
//  AppStoreNew
//
//  Created by Nuno Pereira on 19/03/2019.
//  Copyright © 2019 Nuno Pereira. All rights reserved.
//

import UIKit

class AppsPageHeader: UICollectionReusableView {
    
    //MARK:- Properties
    static let key = String(describing: AppsPageHeader.self)
    private let appsHeaderHorizontalController = AppsHeaderHorizontalController()
    
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
        backgroundColor = .red
        
        addSubview(appsHeaderHorizontalController.view)
        appsHeaderHorizontalController.view.fillSuperview()
    }
}
