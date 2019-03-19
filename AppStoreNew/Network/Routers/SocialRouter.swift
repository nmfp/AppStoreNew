//
//  SocialRouter.swift
//  AppStoreNew
//
//  Created by Nuno Pereira on 19/03/2019.
//  Copyright © 2019 Nuno Pereira. All rights reserved.
//

import Foundation

enum SocialRouter: NetworkResponse {
    case social
    
    var baseUrl: String {
        return "https://api.letsbuildthatapp.com"
    }
    
    var path: String {
        switch self {
        case .social:
            return "/appstore/social"
        }
    }
    
    var method: String {
        return "GET"
    }
    
    var parameters: [URLQueryItem]? {
        return nil
    }
}
