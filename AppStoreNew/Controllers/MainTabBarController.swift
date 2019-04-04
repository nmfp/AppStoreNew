//
//  MainTabBarController.swift
//  AppStoreNew
//
//  Created by Nuno Pereira on 17/03/2019.
//  Copyright © 2019 Nuno Pereira. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBarControllers()
    }
    
    private func setupTabBarControllers() {
        viewControllers = [
            setupTabBarNavigationController(with: "Today", iconName: "today_icon", iconTitle: "Today", viewController: TodayController(collectionViewLayout: UICollectionViewFlowLayout())),
            setupTabBarNavigationController(with: "Apps", iconName: "apps", iconTitle: "Apps", viewController: AppsPageController()),
            setupTabBarNavigationController(with: "Search", iconName: "search", iconTitle: "Search", viewController: AppsSearchController())
        ]
    }
    
    
    private func setupTabBarNavigationController(with title: String, iconName: String, iconTitle: String, viewController: UIViewController = UIViewController()) -> UIViewController {
        viewController.view.backgroundColor = .white
        viewController.title = title
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.navigationBar.prefersLargeTitles = true
        navigationController.tabBarItem.title = iconTitle
        navigationController.tabBarItem.image = UIImage(named: iconName)
        return navigationController
    }
}
