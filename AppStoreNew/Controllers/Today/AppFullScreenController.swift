//
//  AppFullScreenController.swift
//  AppStoreNew
//
//  Created by Nuno Pereira on 04/04/2019.
//  Copyright © 2019 Nuno Pereira. All rights reserved.
//

import UIKit

class AppFullScreenController: UITableViewController {
    
    var dismissHandler: (() -> Void)?
    
    var todayItem: TodayItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    private func setupTableView() {
        tableView.tableFooterView = UIView()
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.register(AppFullScreenHeaderCell.self, forCellReuseIdentifier: AppFullScreenHeaderCell.key)
        tableView.register(AppFullscreenDescriptionCell.self, forCellReuseIdentifier: AppFullscreenDescriptionCell.key)
    }
}

extension AppFullScreenController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = AppFullScreenHeaderCell()
            cell.todayCell.todayItem = todayItem
            cell.delegate = self
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: AppFullscreenDescriptionCell.key, for: indexPath)
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 500.0
    }
}

extension AppFullScreenController: TodayDelegate {
    func dismissToday() {
        dismissHandler?()
    }
}
