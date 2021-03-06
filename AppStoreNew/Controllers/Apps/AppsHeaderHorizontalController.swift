//
//  AppsHeaderHorizontalController.swift
//  AppStoreNew
//
//  Created by Nuno Pereira on 19/03/2019.
//  Copyright © 2019 Nuno Pereira. All rights reserved.
//

import UIKit

class AppsHeaderHorizontalController: UICollectionViewController {
    
    var socialApps: [SocialApp]? {
        didSet {
            collectionView.reloadData()
        }
    }
    
    init() {
        let layout = CollectionSpinningLayout()
        layout.scrollDirection = .horizontal
        super.init(collectionViewLayout: layout)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        collectionView.decelerationRate = .fast
        collectionView.backgroundColor = .white
        collectionView.contentInset = .init(top: 32.0, left: 16.0, bottom: 32.0, right: 16.0)
        collectionView.register(AppsHeaderCell.self, forCellWithReuseIdentifier: AppsHeaderCell.key)
    }
}

extension AppsHeaderHorizontalController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return socialApps?.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AppsHeaderCell.key, for: indexPath) as! AppsHeaderCell
        if let socialApps = socialApps {
            cell.socialApp = socialApps[indexPath.item]
        }
        return cell
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        return .init(top: 0.0, left: 16.0, bottom: 0.0, right: 16.0)
//    }
}

extension AppsHeaderHorizontalController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: collectionView.frame.width - 48.0, height: collectionView.frame.height)
    }
}
