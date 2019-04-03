//
//  AppsRouter.swift
//  AppStoreNew
//
//  Created by Nuno Pereira on 18/03/2019.
//  Copyright © 2019 Nuno Pereira. All rights reserved.
//

import Foundation

protocol NetworkResponse {
    var baseUrl: String { get }
    var path: String { get }
    var method: String { get }
    var parameters: [URLQueryItem]? { get }
}

extension NetworkResponse {
    var url: URL? {
        var components = URLComponents(string: baseUrl)
        components?.queryItems = parameters
        components?.path = path
        return components?.url
    }
    //FIXME: Implement soluction to handle possible url bad format
    var request: URLRequest {
        return URLRequest(url: url!)
    }
}

enum AppsRouter: NetworkResponse {
    case appSearch(String)
    case app(String)
    
    var baseUrl: String {
        return "https://itunes.apple.com"
    }
    
    var method: String {
        switch self {
        case .appSearch:
            return "GET"
        case .app:
            return "GET"
        }
    }
    
    var path: String {
        switch self {
        case .appSearch:
            return "/search"
        case .app:
            return "/lookup"
        }
    }
    
    var parameters: [URLQueryItem]? {
        switch self {
        case .appSearch(let name):
            return [
                URLQueryItem(name: "entity", value: "software"),
                URLQueryItem(name: "term", value: name)
            ]
        case .app(let appId):
            return [
                URLQueryItem(name: "id", value: appId)
            ]
        }
    }
}
