//
//  AppsController.swift
//  AppStoreNew
//
//  Created by Nuno Pereira on 18/03/2019.
//  Copyright © 2019 Nuno Pereira. All rights reserved.
//

import UIKit


class AppsPageController: UICollectionViewController {
    
    private var appGroups = [AppGroup]()
    private var socialApps = [SocialApp]()
    
    private let activityIndicator: UIActivityIndicatorView = {
        let ai = UIActivityIndicatorView(style: .whiteLarge)
        ai.color = .black
        ai.hidesWhenStopped = true
        return ai
    }()
    
    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLoadingAnimation()
        setupCollectionView()
        fetchAppGroups()
    }
    
    private func setupLoadingAnimation() {
        view.addSubview(activityIndicator)
        activityIndicator.fillSuperview()
        activityIndicator.startAnimating()
    }
    
    private func setupCollectionView() {
        collectionView.backgroundColor = .white
        collectionView.register(AppsGroupCell.self, forCellWithReuseIdentifier: AppsGroupCell.key)
        collectionView.register(AppsPageHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: AppsPageHeader.key)
    }
    
    private func fetchAppGroups() {
        
        let dispatchGroup = DispatchGroup()
        
        dispatchGroup.enter()
        AppsService.shared.fetchTopFree(with: AppsGroupRouter.topFree) { (response) in
            dispatchGroup.leave()
            switch response {
            case .success(let appGroup):
                self.appGroups.append(appGroup)
            case .error(let error):
                print(error.localizedDescription)
            }
        }
        
        dispatchGroup.enter()
        AppsService.shared.fetchTopGrossing(with: AppsGroupRouter.topGrossing) { (response) in
            dispatchGroup.leave()
            switch response {
            case .success(let appGroup):
                self.appGroups.append(appGroup)
            case .error(let error):
                print(error.localizedDescription)
            }
        }
        
        dispatchGroup.enter()
        AppsService.shared.fetchGames(with: AppsGroupRouter.games) { (response) in
            dispatchGroup.leave()
            switch response {
            case .success(let appGroup):
                self.appGroups.append(appGroup)
            case .error(let error):
                print(error.localizedDescription)
            }
        }
        
        dispatchGroup.enter()
        AppsService.shared.fetchSocial(with: SocialRouter.social) { (response) in
            dispatchGroup.leave()
            switch response {
            case .success(let socialApps):
                self.socialApps = socialApps
            case .error(let error):
                print(error.localizedDescription)
            }
        }
        
        dispatchGroup.notify(queue: .main) {
            self.activityIndicator.stopAnimating()
            self.collectionView.reloadData()
        }
    }
}

extension AppsPageController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return appGroups.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AppsGroupCell.key, for: indexPath) as! AppsGroupCell
        cell.appGroup = appGroups[indexPath.item]
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: AppsPageHeader.key, for: indexPath) as! AppsPageHeader
        header.socialApps = socialApps
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
