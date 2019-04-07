//
//  AppFullScreenController.swift
//  AppStoreNew
//
//  Created by Nuno Pereira on 04/04/2019.
//  Copyright © 2019 Nuno Pereira. All rights reserved.
//

import UIKit

class AppFullScreenController: UIViewController {
    
    private lazy var closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "close_button").withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)
        return button
    }()
    
    lazy var tableView: UITableView = {
        let tv = UITableView(frame: .zero, style: .plain)
        tv.dataSource = self
        tv.delegate = self
        return tv
    }()
    
    var dismissHandler: (() -> Void)?
    
    var todayItem: TodayItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupCloseButton()
    }
    
    private func setupCloseButton() {
        view.addSubview(closeButton)
        closeButton.anchor(top: view.topAnchor, leading: nil, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 48.0, left: 0.0, bottom: 0.0, right: 20.0), size: .init(width: 34.0, height: 34.0))
    }
    
    private func setupTableView() {
        view.clipsToBounds = true
        tableView.tableFooterView = UIView()
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.register(AppFullScreenHeaderCell.self, forCellReuseIdentifier: AppFullScreenHeaderCell.key)
        tableView.register(AppFullscreenDescriptionCell.self, forCellReuseIdentifier: AppFullscreenDescriptionCell.key)
        
        view.addSubview(tableView)
        tableView.fillSuperview()
    }
    
    @objc private func handleDismiss() {
        dismissHandler?()
    }
}

extension AppFullScreenController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y < 0 {
            scrollView.isScrollEnabled = false
            scrollView.isScrollEnabled = true
        }
    }
}
extension AppFullScreenController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = AppFullScreenHeaderCell()
            cell.clipsToBounds = true
            cell.todayCell.todayItem = todayItem
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: AppFullscreenDescriptionCell.key, for: indexPath)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 500.0//UITableView.automaticDimension
    }
}
UICollectionViewController
