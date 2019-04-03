//
//  AppController.swift
//  AppStoreNew
//
//  Created by Nuno Pereira on 30/03/2019.
//  Copyright © 2019 Nuno Pereira. All rights reserved.
//

import UIKit

class AppDetailController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    private var appId: String?
    private var appResult: Result?
    
    init(width id: String) {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
        self.appId = id
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.largeTitleDisplayMode = .never
        
        setupCollectionView()
        fetchAppData()
    }
    
    private func fetchAppData() {
        AppsService.shared.fetchApp(with: AppsRouter.app(appId ?? "")) { (response) in
            switch response {
            case .success(let result):
                self.appResult = result.results.first
            case .error(let error):
                print(error.localizedDescription)
            }
            
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    private func setupCollectionView() {
        collectionView.backgroundColor = .white
        collectionView.register(AppDetailCell.self, forCellWithReuseIdentifier: AppDetailCell.key)
        collectionView.register(PreviewCell.self, forCellWithReuseIdentifier: PreviewCell.key)
        collectionView.register(ReviewRowCell.self, forCellWithReuseIdentifier: ReviewRowCell.key)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item == 0 {let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AppDetailCell.key, for: indexPath) as! AppDetailCell
        cell.app = appResult
            return cell} else if indexPath.item == 1{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PreviewCell.key, for: indexPath) as! PreviewCell
            cell.screenshotsController.app = appResult
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReviewRowCell.key, for: indexPath) as! ReviewRowCell
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if indexPath.item == 0{let dummyCell = AppDetailCell(frame: .init(x: 0.0, y: 0.0, width: collectionView.frame.width, height: 1000))
        dummyCell.app = appResult
        dummyCell.layoutIfNeeded()
        
        let estimatedSize = dummyCell.systemLayoutSizeFitting(.init(width: view.frame.width, height: 1000))
        
            return .init(width: collectionView.frame.width, height: estimatedSize.height)}else if indexPath.item == 1 {
            return .init(width: collectionView.frame.width, height: 500.0)
        } else {
            return .init(width: view.frame.width, height: 280.0)
        }
    }
}
