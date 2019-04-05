//
//  TodayController.swift
//  AppStoreNew
//
//  Created by Nuno Pereira on 04/04/2019.
//  Copyright © 2019 Nuno Pereira. All rights reserved.
//

import UIKit

class TodayController: UICollectionViewController {
    
    private var appFullscreenController: AppFullScreenController?
    private var startingFrame: CGRect?
    private var topConstraint: NSLayoutConstraint?
    private var leadingConstraint: NSLayoutConstraint?
    private var heightConstraint: NSLayoutConstraint?
    private var widthConstraint: NSLayoutConstraint?
    
    let items: [TodayItem] = [
        .init(category: "LIFE HACK", title: "Utilizing your Time", image: #imageLiteral(resourceName: "garden"), description: "All the tools and apps you need to intelligently organize your life the right way.", backgroundColor: .white),
        .init(category: "HOLIDAYS", title: "Travel on Budget", image: #imageLiteral(resourceName: "holiday"), description: "Find out all you need to know on how to travel without packing everything!", backgroundColor: #colorLiteral(red: 0.9893129468, green: 0.9681989551, blue: 0.7294917703, alpha: 1))
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    private func setupCollectionView() {
        collectionView.backgroundColor = #colorLiteral(red: 0.9531119466, green: 0.9487840533, blue: 0.9570327401, alpha: 1)
        collectionView.register(TodayCell.self, forCellWithReuseIdentifier: TodayCell.key)
    }
    
    private func setupConstraints() {
        guard let originFrame = self.startingFrame else { return }
        self.topConstraint = self.appFullscreenController?.view.topAnchor.constraint(equalTo: self.view.topAnchor, constant: originFrame.origin.y)
        self.leadingConstraint = self.appFullscreenController?.view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: originFrame.origin.x)
        self.heightConstraint = self.appFullscreenController?.view.heightAnchor.constraint(equalToConstant: originFrame.height)
        self.widthConstraint = self.appFullscreenController?.view.widthAnchor.constraint(equalToConstant: originFrame.width)
        [topConstraint, leadingConstraint, heightConstraint, widthConstraint].forEach({ $0?.isActive = true })
        self.view.layoutIfNeeded()
    }
    
     func handleExpandCell() {
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut, animations: {
            self.topConstraint?.constant = 0
            self.leadingConstraint?.constant = 0
            self.heightConstraint?.constant = self.view.frame.height
            self.widthConstraint?.constant = self.view.frame.width
            self.view.layoutIfNeeded()
            self.tabBarController?.tabBar.transform = CGAffineTransform(translationX: 0.0, y: self.tabBarController?.tabBar.frame.height ?? 0.0)
        }, completion: nil)
    }
    
    @objc func handleRemoveCell() {
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut, animations: {
            self.appFullscreenController?.tableView.contentOffset = .zero
            
            guard let originFrame = self.startingFrame else { return }
            self.topConstraint?.constant = originFrame.origin.y
            self.leadingConstraint?.constant = originFrame.origin.x
            self.heightConstraint?.constant = originFrame.height
            self.widthConstraint?.constant = originFrame.width
            self.view.layoutIfNeeded()
            self.tabBarController?.tabBar.transform = .identity
            
            guard let headerCell = self.appFullscreenController?.tableView.cellForRow(at: [0,0]) as? AppFullScreenHeaderCell else { return }
            headerCell.todayCell.topConstraint?.constant = 24.0
            headerCell.layoutIfNeeded()
            
        }) { _ in
            self.appFullscreenController?.view.removeFromSuperview()
            self.appFullscreenController?.removeFromParent()
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TodayCell.key, for: indexPath) as! TodayCell
        cell.todayItem = items[indexPath.item]
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) else { return }
        guard let startingFrame = cell.superview?.convert(cell.frame, to: self.view) else { return }
        
//        cell.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleExpandCell(gesture:))))
        
        let appFullscreenController = AppFullScreenController()
        appFullscreenController.todayItem = items[indexPath.item]
//        appFullscreenController.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleRemoveCell)))
        appFullscreenController.view.translatesAutoresizingMaskIntoConstraints = false
        appFullscreenController.view.layer.cornerRadius = 16.0
        view.addSubview(appFullscreenController.view)
        addChild(appFullscreenController)
        
        self.startingFrame = startingFrame
        self.appFullscreenController = appFullscreenController
        
        guard let headerCell = appFullscreenController.tableView.cellForRow(at: [0,0]) as? AppFullScreenHeaderCell else { return }
        headerCell.todayCell.topConstraint?.constant = 48.0
        headerCell.layoutIfNeeded()
        
        appFullscreenController.dismissHandler = {
            self.handleRemoveCell()
        }
        
        setupConstraints()
        handleExpandCell()
    }
}

extension TodayController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let dummyCell = TodayCell(frame: .init(x: 0.0, y: 0.0, width: collectionView.frame.width, height: 1000))
        dummyCell.layoutIfNeeded()
        let targetSize: CGSize = .init(width: view.frame.width, height: 1000)
        let correctSize = dummyCell.systemLayoutSizeFitting(targetSize)
        
//        return .init(width: view.frame.width - 48, height: correctSize.height)
        return .init(width: view.frame.width - 64, height: 450)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 32.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 32.0, left: 0.0, bottom: 32.0, right: 0.0)
    }
}

struct TodayItem {
    let category: String
    let title: String
    let image: UIImage
    let description: String
    let backgroundColor: UIColor
}
