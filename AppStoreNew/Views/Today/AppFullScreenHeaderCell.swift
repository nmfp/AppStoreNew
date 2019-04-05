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
    
    private lazy var closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "close_button").withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        backgroundColor = todayItem?.backgroundColor
        todayCell = TodayCell()
        todayCell.todayItem = todayItem
        todayCell.topConstraint?.constant = 48.0
        addSubview(todayCell)
        addSubview(closeButton)
        todayCell.fillSuperview()
        closeButton.anchor(top: topAnchor, leading: nil, bottom: nil, trailing: trailingAnchor, padding: .init(top: 48.0, left: 0.0, bottom: 0.0, right: 20.0), size: .init(width: 34.0, height: 34.0))
    }
    
    @objc private func handleDismiss() {
        closeButton.alpha = 0.0
        delegate?.dismissToday()
    }
}

protocol TodayDelegate: class {
    func dismissToday()
}
