//
//  TodayItem.swift
//  AppStoreNew
//
//  Created by Nuno Pereira on 05/04/2019.
//  Copyright © 2019 Nuno Pereira. All rights reserved.
//

import UIKit

struct TodayItem {
    let category: String
    let title: String
    let image: UIImage
    let description: String
    let backgroundColor: UIColor
    
    let cellType: CellType
    
    enum CellType {
        case single, multiple([FeedResult])
    }
}
