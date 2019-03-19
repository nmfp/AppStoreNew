//
//  AppsController.swift
//  AppStoreNew
//
//  Created by Nuno Pereira on 18/03/2019.
//  Copyright © 2019 Nuno Pereira. All rights reserved.
//

import UIKit


class AppsPageController: UICollectionViewController {
    
    var appGroup: AppGroup?
    
    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        fetchAppGroups()
    }
    
    private func setupCollectionView() {
        collectionView.backgroundColor = .white
        collectionView.register(AppsGroupCell.self, forCellWithReuseIdentifier: AppsGroupCell.key)
        collectionView.register(AppsPageHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: AppsPageHeader.key)
    }
    
    private func fetchAppGroups() {
        AppsService.shared.fetchGroups(with: AppsGroupRouter.group) { (response) in
            switch response {
            case .success(let appGroup):
                self.appGroup = appGroup
            case .error(let error):
                print(error.localizedDescription)
            }
            
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
}

extension AppsPageController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AppsGroupCell.key, for: indexPath) as! AppsGroupCell
        cell.appGroup = appGroup
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: AppsPageHeader.key, for: indexPath) as! AppsPageHeader
        return header
    }
}

extension AppsPageController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: collectionView.frame.width, height: 300)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return .init(width: collectionView.frame.width, height: 300.0)
    }
}
