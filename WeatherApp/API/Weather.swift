//
//  Weather.swift
//  WeatherApp
//
//  Created by David D on 12/19/18.
//  Copyright © 2018 David D. All rights reserved.
//

import Foundation

class Weather: Codable {
    let forecast: Forecast
}

struct Forecast: Codable {
    let forecastText: ForecastText
    
    // enum for actual JSON values from API response
    private enum CodingKeys: String, CodingKey {
        case forecastText = "txt_forecast"
    }
}

struct ForecastText: Codable {
    let date: String
    let forecastDays: [ForecastDay]
    
    private enum CodingKeys: String, CodingKey {
        case date
        case forecastDays = "forecastday"
    }
}

struct ForecastDay: Codable {
    let iconUrl: String
    let day: String
    let description: String
    
    private enum CodingKeys: String, CodingKey {
        case iconUrl = "icon_url"
        case day = "title"
        case description = "fcttext"
    }
}

