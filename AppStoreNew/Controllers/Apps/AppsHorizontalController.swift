//
//  AppsHorizontalController.swift
//  AppStoreNew
//
//  Created by Nuno Pereira on 18/03/2019.
//  Copyright © 2019 Nuno Pereira. All rights reserved.
//

import UIKit

class AppsHorizontalController: UICollectionViewController {
    
    //MARK:- Properties
    private let rowsPerPage: Int = 3
    private let lineSpacing: CGFloat = 10.0
    private let topBottomMargin: CGFloat = 12.0
    
    var showAppDetail: ((FeedResult) -> Void)?
    var appGroup: AppGroup? {
        didSet {
            self.collectionView.reloadData()
        }
    }
    
    //MARK:- Initializers
    init() {
        let layout = CollectionSpinningLayout()
        layout.scrollDirection = .horizontal
        super.init(collectionViewLayout: layout)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    //MARK:- System Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        collectionView.decelerationRate = .fast
        collectionView.backgroundColor = .white
        collectionView.contentInset = .init(top: 12.0, left: 16.0, bottom: 12.0, right: 16.0)
        collectionView.register(AppRowCell.self, forCellWithReuseIdentifier: AppRowCell.key)
        
        if let layout = collectionViewLayout as? UICollectionViewFlowLayout {
            layout.minimumLineSpacing = 10
        }
    }
}

//MARK:- Datasource Methods
extension AppsHorizontalController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return appGroup?.feed.results.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AppRowCell.key, for: indexPath) as! AppRowCell
        if let feedResults = appGroup?.feed.results {
            cell.feedResult = feedResults[indexPath.item]
        }
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let app = appGroup?.feed.results[indexPath.item] {
            showAppDetail?(app)
        }
    }
}

//MARK:- Layout Methods
extension AppsHorizontalController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = (collectionView.frame.height - (topBottomMargin * 2) - lineSpacing *  (CGFloat(rowsPerPage) - 1)) / CGFloat(rowsPerPage)
        return .init(width: collectionView.frame.width - 48.0, height: height)
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 20
//    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        return .init(top: 12.0, left: 16.0, bottom: 12.0, right: 16.0)
//    }
}
