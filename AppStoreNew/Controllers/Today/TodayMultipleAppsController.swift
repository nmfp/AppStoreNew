//
//  TodayMultipleAppsController.swift
//  AppStoreNew
//
//  Created by Nuno Pereira on 05/04/2019.
//  Copyright © 2019 Nuno Pereira. All rights reserved.
//

import UIKit

class TodayMultipleAppsController: UICollectionViewController {
    
    enum Mode {
        case compressed, fullscreen
    }
    
    private var mode: Mode
    
    var results = [FeedResult]()
    private let minSpacing: CGFloat = 16.0
    
    private lazy var closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "close_button").withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(handleClose), for: .touchUpInside)
        return button
    }()
    
    init(mode: Mode) {
        self.mode = mode
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: true)
        setupCollectionView()
        
        if mode == .fullscreen {
            setupCloseButton()
        }
    }
    
    private func setupCloseButton() {
        view.addSubview(closeButton)
        closeButton.anchor(top: view.topAnchor, leading: nil, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 44.0, left: 0.0, bottom: 0.0, right: 24.0), size: .init(width: 44.0, height: 44.0))
    }
    
    private func setupCollectionView() {
        if mode == .compressed {
            collectionView.isScrollEnabled = false
        }
        collectionView.backgroundColor = .white
        collectionView.register(MultipleAppCell.self, forCellWithReuseIdentifier: MultipleAppCell.key)
    }
    
    @objc func handleClose() {
        dismiss(animated: true, completion: nil)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mode == .compressed ? min(4, results.count) : results.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MultipleAppCell.key, for: indexPath) as! MultipleAppCell
        cell.feedResult = results[indexPath.item]
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let app = results[indexPath.item]
        let appDetailController = AppDetailController(width: app.id)
        navigationController?.pushViewController(appDetailController, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 24.0, left: 0.0, bottom: 24.0, right: 0.0)
    }
}

extension TodayMultipleAppsController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let cellNumbers = CGFloat(min(4, results.count))
        let height: CGFloat = 68//(view.frame.height - ((cellNumbers - 1) * minSpacing)) / 4
        if mode == .fullscreen {
            return .init(width: view.frame.width - 48, height: height)
        }
        return .init(width: view.frame.width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return minSpacing
    }
}



class BackEnabledNavigationController: UINavigationController, UIGestureRecognizerDelegate {
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.interactivePopGestureRecognizer?.delegate = self
    }
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return self.viewControllers.count > 1
    }
}
