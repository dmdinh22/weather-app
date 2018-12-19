//
//  APIClient.swift
//  WeatherApp
//
//  Created by David D on 12/19/18.
//  Copyright © 2018 David D. All rights reserved.
//

import Foundation

enum Result<V, E: Error> {
    case value(V)
    case error(Error)
}

enum APIError: Error {
    case apiError
    case badResponse
    case jsonDecoder
    case unknown(String)
}

protocol APIClient {
    var session: URLSession { get }
    
    // @escaping for when the closure is passed as arg to fn,
    // but is called after fn returns
    func fetch<V: Codable>(with request: URLRequest, completion: @escaping (Result<V, APIError>) -> Void)
}

extension APIClient {
    // default implementation
    func fetch<V: Codable>(with request: URLRequest, completion: @escaping (Result<V, APIError>) -> Void) {
        let task = session.dataTask(with: request) { (data, response, error) in
            guard error == nil else {
                completion(.error(APIError.apiError))
                return
            }
            
            guard let response = response as? HTTPURLResponse, 200..<299 ~= response.statusCode else {
                completion(.error(APIError.badResponse))
                return
            }
            
            guard let value = try? JSONDecoder().decode(V.self, from: data!) else {
                completion(.error(APIError.jsonDecoder))
                return
            }
            
            completion(.value(value))
        }
        // need the task to resume to make the API call
        task.resume()
    }
}
