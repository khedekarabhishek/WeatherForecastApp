//
//  HomeViewDataSourceMock.swift
//  WeatherForecastAppTests
//
//  Created by Abhishek Khedekar on 24/04/23.
//

import Foundation
@testable import WeatherForecastApp

class HomeViewDataSourceMock: HomeViewDataSourceProtocol {
    let forecastModel = ForecastModel(name: "London",
                                      id: 1,
                                      mainModel: MainModel(temp: 11,
                                                           feelsLike: 11,
                                                           tempMin: 11,
                                                           tempMax: 11,
                                                           pressure: 11,
                                                           humidity: 11),
                                      weatherModel: [WeatherModel(id: 1,
                                                                  main: "main",
                                                                  description: "description",
                                                                  icon: "10d")])
    func getForeCastData(urlString: String,
                         completion: @escaping (ForecastModel?) -> Void) {
        if !urlString.isEmpty {
            completion(forecastModel)
        } else {
            completion(nil)
        }
    }
}
