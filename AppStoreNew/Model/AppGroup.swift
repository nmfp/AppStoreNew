//
//  AppGroup.swift
//  AppStoreNew
//
//  Created by Nuno Pereira on 19/03/2019.
//  Copyright © 2019 Nuno Pereira. All rights reserved.
//

import Foundation

struct AppGroup: Decodable {
    let feed: Feed
}

struct Feed: Decodable {
    let title: String
    let results: [FeedResult]
}

struct FeedResult: Decodable {
    let name: String
    let artistName: String
    let artworkUrl100: String
    let id: String
}
