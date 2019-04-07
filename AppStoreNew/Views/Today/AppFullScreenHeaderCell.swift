//
//  AppFullScreenHeaderCell.swift
//  AppStoreNew
//
//  Created by Nuno Pereira on 04/04/2019.
//  Copyright © 2019 Nuno Pereira. All rights reserved.
//

import UIKit

class AppFullScreenHeaderCell: UITableViewCell {
    
    static let key = String(describing: AppFullScreenHeaderCell.self)
    var delegate: TodayDelegate?
    var todayCell: TodayCell!
    
    private var todayItem: TodayItem?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        backgroundColor = todayItem?.backgroundColor
        todayCell = TodayCell(frame: .zero)
        todayCell.todayItem = todayItem
        todayCell.topConstraint?.constant = 48.0
        addSubview(todayCell)
        todayCell.fillSuperview()
    }
}

protocol TodayDelegate: class {
    func dismissToday()
}
