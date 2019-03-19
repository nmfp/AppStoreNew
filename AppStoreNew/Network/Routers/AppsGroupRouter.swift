//
//  AppsGroupRouter.swift
//  AppStoreNew
//
//  Created by Nuno Pereira on 19/03/2019.
//  Copyright © 2019 Nuno Pereira. All rights reserved.
//

import Foundation

enum AppsGroupRouter: String, NetworkResponse {
    case topFree = "top-free"
    case topGrossing = "top-grossing"
    case games = "new-games-we-love"
    
    var baseUrl: String {
        return "https://rss.itunes.apple.com"
    }
    
    var path: String {
        switch self {
        case .topFree:
            return "/api/v1/us/ios-apps/\(AppsGroupRouter.topFree.rawValue)/all/50/explicit.json"
        case .topGrossing:
            return "/api/v1/us/ios-apps/\(AppsGroupRouter.topGrossing.rawValue)/all/50/explicit.json"
        case .games:
            return "/api/v1/us/ios-apps/\(AppsGroupRouter.games.rawValue)/all/50/explicit.json"
        }
    }
    
    var method: String {
        return "GET"
    }
    
    var parameters: [URLQueryItem]? {
        return nil
    }
}
