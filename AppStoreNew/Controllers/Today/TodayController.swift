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
    
    private let activityIndicator: UIActivityIndicatorView = {
        let ai = UIActivityIndicatorView()
        ai.color = .darkGray
        ai.hidesWhenStopped = true
        ai.startAnimating()
        return ai
    }()
    
    private var blurEffectView: UIVisualEffectView!
    
    var items: [TodayItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(activityIndicator)
        activityIndicator.centerInSuperview(size: .init(width: 80.0, height: 80.0))
        setupCollectionView()
        setupBlurView()
        fetchData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBar()
        tabBarController?.tabBar.superview?.setNeedsLayout()
    }
    
    private func setupBlurView() {
        blurEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .regular))
        blurEffectView.alpha = 0
        view.addSubview(blurEffectView)
        blurEffectView.fillSuperview()
    }
    
    private func fetchData() {
        
        let dispatchGroup = DispatchGroup()
        var topGrossing: AppGroup?
        var games: AppGroup?
        
        dispatchGroup.enter()
        AppsService.shared.fetchGames(with: AppsGroupRouter.games) { (response) in
            switch response {
            case .success(let results):
               games = results
            case .error(let error):
                print(error.localizedDescription)
            }
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        AppsService.shared.fetchTopGrossing(with: AppsGroupRouter.topGrossing) { (response) in
            switch response {
            case .success(let results):
                topGrossing = results
            case .error(let error):
                print(error.localizedDescription)
            }
            dispatchGroup.leave()
        }
        
        
        dispatchGroup.notify(queue: .main) {
            
            self.items = [
            .init(category: "LIFE HACK", title: "Utilizing your Time", image: #imageLiteral(resourceName: "garden"), description: "All the tools and apps you need to intelligently organize your life the right way.", backgroundColor: .white, cellType: .single),
            .init(category: "THE DAILY LIST", title: "Test-Drive these CarPlay Apps", image: #imageLiteral(resourceName: "garden"), description: "", backgroundColor: .white, cellType: .multiple(games?.feed.results ?? [])),
            .init(category: "THE DAILY LIST", title: "Top Grossing iPhone Apps", image: #imageLiteral(resourceName: "garden"), description: "", backgroundColor: .white, cellType: .multiple(topGrossing?.feed.results ?? [])),
            .init(category: "HOLIDAYS", title: "Travel on Budget", image: #imageLiteral(resourceName: "holiday"), description: "Find out all you need to know on how to travel without packing everything!", backgroundColor: #colorLiteral(red: 0.9893129468, green: 0.9681989551, blue: 0.7294917703, alpha: 1), cellType: .single)
            ]
            
            self.activityIndicator.stopAnimating()
            self.collectionView.reloadData()
        }
    }
    
    private func setupNavigationBar() {
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    private func setupCollectionView() {
        collectionView.backgroundColor = #colorLiteral(red: 0.9531119466, green: 0.9487840533, blue: 0.9570327401, alpha: 1)
        collectionView.register(TodayCell.self, forCellWithReuseIdentifier: TodayCell.key)//TodayItem.CellType.single.rawValue)
        collectionView.register(TodayMultipleAppsCell.self, forCellWithReuseIdentifier: TodayMultipleAppsCell.key)//TodayItem.CellType.multiple.rawValue)
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
            
            self.appFullscreenController?.view.transform = .identity
            self.blurEffectView.alpha = 0
            
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
//        if indexPath.row == 1 {
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TodayMultipleAppsCell.key, for: indexPath) as! TodayMultipleAppsCell
//            cell.todayItem = items[indexPath.item]
//            return cell
//        }
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TodayCell.key, for: indexPath) as! TodayCell
//        cell.todayItem = items[indexPath.item]
//        return cell
        
        
        
        var id: String
        switch items[indexPath.item].cellType {
        case .single:
            id = TodayCell.key
        case .multiple:
            id = TodayMultipleAppsCell.key
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: id, for: indexPath) as! TodayBaseCell
        cell.todayItem = items[indexPath.item]
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        switch items[indexPath.item].cellType {
        case .multiple(let results):
            showMultipleAppsScreen(with: results)
        default:
            setupAppFullScreen(indexPath: indexPath)
            setupAppFullScreenBackToOrigin(indexPath: indexPath)
            handleExpandCell()
        }
    }
    
    private func setupAppFullScreenBackToOrigin(indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) else { return }
        guard let startingFrame = cell.superview?.convert(cell.frame, to: self.view) else { return }
        self.startingFrame = startingFrame
        setupConstraints()
    }
    
    private func setupAppFullScreen(indexPath: IndexPath) {
        let appFullscreenController = AppFullScreenController()
        appFullscreenController.todayItem = items[indexPath.item]
        appFullscreenController.view.translatesAutoresizingMaskIntoConstraints = false
        appFullscreenController.view.layer.cornerRadius = 16.0
        view.addSubview(appFullscreenController.view)
        addChild(appFullscreenController)
        
        self.blurEffectView.alpha = 1
        
        guard let headerCell = appFullscreenController.tableView.cellForRow(at: [0,0]) as? AppFullScreenHeaderCell else { return }
        headerCell.todayCell.topConstraint?.constant = 48.0
        headerCell.layoutIfNeeded()
        
        appFullscreenController.dismissHandler = {
            self.handleRemoveCell()
        }
        
        self.appFullscreenController = appFullscreenController
        
        let dragGesture = UIPanGestureRecognizer(target: self, action: #selector(handleDrag))
        dragGesture.delegate = self
        appFullscreenController.view.addGestureRecognizer(dragGesture)
        
    }
    
    var appFullscreenBeginOffset: CGFloat!
    
    @objc func handleDrag(gesture: UIPanGestureRecognizer) {
        guard appFullscreenController?.tableView.contentOffset.y ?? 0 <= 0 else { return }
        
        if gesture.state == .began {
            appFullscreenBeginOffset = appFullscreenController?.tableView.contentOffset.y ?? 0.0
        }
        
        let translationY = gesture.translation(in: appFullscreenController?.view).y
        if gesture.state == .changed {
            if translationY > 0 {
                
                let trueOffset = translationY - appFullscreenBeginOffset
                
                var scale = 1 - trueOffset / 1000
                
                scale = min(1, scale)
                scale = max(0.5, scale)
                
                let transform: CGAffineTransform = .init(scaleX: scale, y: scale)
                self.appFullscreenController?.view.transform = transform
            }
        }
        
        if gesture.state == .ended {
            if translationY > 0 {
                handleRemoveCell()
            }
        }
    }
    
    private func showMultipleAppsScreen(with apps: [FeedResult]) {
        let appsController = TodayMultipleAppsController(mode: .fullscreen)
        appsController.results = apps
        present(BackEnabledNavigationController(rootViewController: appsController), animated: true, completion: nil)
    }
}

extension TodayController : UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}

extension TodayController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let dummyCell = TodayCell(frame: .init(x: 0.0, y: 0.0, width: collectionView.frame.width, height: 1000))
        dummyCell.layoutIfNeeded()
        let targetSize: CGSize = .init(width: view.frame.width, height: 1000)
        let correctSize = dummyCell.systemLayoutSizeFitting(targetSize)
        
//        return .init(width: view.frame.width - 48, height: correctSize.height)
        return .init(width: view.frame.width - 64, height: 500)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 32.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 32.0, left: 0.0, bottom: 32.0, right: 0.0)
    }
}


