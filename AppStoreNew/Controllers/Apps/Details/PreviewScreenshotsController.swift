//
//  PreviewScreenshotsController.swift
//  AppStoreNew
//
//  Created by Nuno Pereira on 03/04/2019.
//  Copyright © 2019 Nuno Pereira. All rights reserved.
//

import UIKit

class PreviewScreenshotsController: UICollectionViewController {
    
    var app: Result? {
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
        collectionView.backgroundColor = .white
        collectionView.contentInset = .init(top: 0.0, left: 16.0, bottom: 0.0, right: 16.0)
        collectionView.register(ScreenshotCell.self, forCellWithReuseIdentifier: ScreenshotCell.key)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return app?.screenshotUrls.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ScreenshotCell.key, for: indexPath) as! ScreenshotCell
        cell.imageUrlString = app?.screenshotUrls[indexPath.item]
        return cell
    }
}

extension PreviewScreenshotsController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: 250.0, height: view.frame.height)
    }
}
