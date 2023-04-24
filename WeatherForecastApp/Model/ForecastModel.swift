//
//  WeatherModel.swift
//  WeatherForecastApp
//
//  Created by Abhishek Khedekar on 22/04/23.
//

import Foundation

struct ForecastModel: Decodable {
    let name: String
    let id: Int
    let mainModel: MainModel
    let weatherModel: [WeatherModel]
    
    enum CodingKeys: String, CodingKey {
        case name, id
        case mainModel = "main"
        case weatherModel = "weather"
    }
}

struct MainModel: Codable {
    let temp: Double
    let feelsLike: Double
    let tempMin: Double
    let tempMax: Double
    let pressure: Double
    let humidity: Double

    enum CodingKeys: String, CodingKey {
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case temp, pressure, humidity
    }
}

struct WeatherModel: Decodable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

