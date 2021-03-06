//
//  SearchResult.swift
//  AppStoreNew
//
//  Created by Nuno Pereira on 17/03/2019.
//  Copyright © 2019 Nuno Pereira. All rights reserved.
//

import Foundation

struct SearchResult: Codable {
    let resultCount: Int
    let results: [Result]
}

struct Result: Codable {
    let trackId: Int
    let primaryGenreName: String
    let trackName: String
    let averageUserRating: Float?
    let screenshotUrls: [String]
    let artworkUrl100: String //app icon
    var formattedPrice: String?
    let description: String
    var releaseNotes: String?
}
