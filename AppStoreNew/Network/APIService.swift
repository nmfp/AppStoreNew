//
//  APIService.swift
//  AppStoreNew
//
//  Created by Nuno Pereira on 17/03/2019.
//  Copyright © 2019 Nuno Pereira. All rights reserved.
//

import Foundation

enum APIResponse<T> {
    case success(T)
    case error(Error)
}

enum APIError: Error {
    case unknown, badResponse, badRequest, badData, errorParsing
}

protocol APIService {
    var session: URLSession { get }
    func getData<T: Decodable>(with request: URLRequest, completion: @escaping (APIResponse<T>) -> Void)
}

extension APIService {
    var session: URLSession {
        return URLSession.shared
    }
    
    func getData<T: Decodable>(with request: URLRequest, completion: @escaping (APIResponse<T>) -> Void) {
        session.dataTask(with: request) { (data, response, error) in
            guard error == nil else {
                completion(APIResponse.error(error!))
                return
            }
            
            guard let resp = response as? HTTPURLResponse, 200...299 ~= resp.statusCode else {
                completion(APIResponse.error(APIError.badResponse))
                return
            }
            
            guard let data = data else {
                completion(APIResponse.error(APIError.badData))
                return
            }
            
            do {
                let value = try JSONDecoder().decode(T.self, from: data)
                completion(APIResponse.success(value))
            } catch {
                completion(APIResponse.error(APIError.errorParsing))
            }
        }.resume()
    }
}
