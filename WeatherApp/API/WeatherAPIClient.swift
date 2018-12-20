//
//  WeatherAPIClient.swift
//  WeatherApp
//
//  Created by David D on 12/19/18.
//  Copyright © 2018 David D. All rights reserved.
//

import Foundation

class WeatherAPIClient: APIClient {
    var session: URLSession
    
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    func weather(with endpoint: WeatherEndpoint, completion: @escaping (Result<ForecastText, APIError>) -> Void) {
        let request = endpoint.request
        self.fetch(with: request) { (result: Result<Weather, APIError>) in
            switch result {
            case .value(let weather):
                let weather = weather.forecast.forecastText
                completion(.value(weather))
            case .error(let error):
                completion(.error(error))
                break
            }
        }
    }
}
