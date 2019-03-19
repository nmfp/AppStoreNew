//
//  AppsService.swift
//  AppStoreNew
//
//  Created by Nuno Pereira on 18/03/2019.
//  Copyright © 2019 Nuno Pereira. All rights reserved.
//

import Foundation

struct AppsService: APIService {
    static let shared = AppsService()
 
    func fetchApps(with router: NetworkResponse, completion: @escaping (APIResponse<SearchResult>) -> Void) {
        let request = router.request
        getData(with: request, completion: completion)
    }
    
    func fetchGroups(with router: NetworkResponse, completion: @escaping (APIResponse<AppGroup>) -> Void) {
        let request = router.request
        getData(with: request, completion: completion)
    }

}
