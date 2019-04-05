//
//  TodayMultipleAppsCell.swift
//  AppStoreNew
//
//  Created by Nuno Pereira on 05/04/2019.
//  Copyright © 2019 Nuno Pereira. All rights reserved.
//

import UIKit

class TodayMultipleAppsCell: TodayBaseCell {
    
    static let key: String = String(describing: TodayMultipleAppsCell.self)
    
    let multipleAppsController = UIViewController()
    
    private let categoryLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20.0)
        return label
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 26.0)
        label.numberOfLines = 2
        return label
    }()
    
    override var todayItem: TodayItem? {
        didSet {
            categoryLabel.text = todayItem?.category
            titleLabel.text = todayItem?.title
            backgroundColor = todayItem?.backgroundColor
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }
    
    
    private func setupViews() {
        backgroundColor = .white
        multipleAppsController.view.backgroundColor = .red
        let stackView = UIStackView(arrangedSubviews: [
            categoryLabel,
            titleLabel,
            multipleAppsController.view
            ])
        stackView.axis = .vertical
        stackView.spacing = 12.0
        addSubview(stackView)
        stackView.fillSuperview(padding: .init(top: 24.0, left: 24.0, bottom: 24.0, right: 24.0))
    }
}
