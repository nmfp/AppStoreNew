//
//  AppsGroupRouter.swift
//  AppStoreNew
//
//  Created by Nuno Pereira on 19/03/2019.
//  Copyright © 2019 Nuno Pereira. All rights reserved.
//

import Foundation

enum AppsGroupRouter: NetworkResponse {
    case group
    
    var baseUrl: String {
        switch self {
        case .group:
            return "https://rss.itunes.apple.com"
        }
    }
    
    var path: String {
        switch self {
        case .group:
            return "/api/v1/us/ios-apps/top-free/all/50/explicit.json"
        }
    }
    
    var method: String {
        switch self {
        case .group:
            return "GET"
        }
    }
    
    var parameters: [URLQueryItem]? {
        switch self {
        case .group:
            return nil
        }
    }
}
