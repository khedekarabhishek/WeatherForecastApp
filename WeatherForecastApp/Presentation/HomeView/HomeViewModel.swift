//
//  HomeViewModel.swift
//  WeatherForecastApp
//
//  Created by Abhishek Khedekar on 22/04/23.
//

import Foundation
import CoreLocation

typealias CompletionType = (Bool) -> ()

class HomeViewModel: ObservableObject {
    @Published var weatherForeCastViewUIModel: WeatherForeCastViewUIModel?
    var completionHandler: CompletionType?
    private let homeViewDataSource: HomeViewDataSourceProtocol
    
    init(homeViewDataSource: HomeViewDataSourceProtocol = HomeViewDataSource()) {
        self.homeViewDataSource = homeViewDataSource
    }

    func getForeCastData(cityName: String) {
        let myCityName = cityName.replacingOccurrences(of: " ", with: "")
        let urlString = endPointURLs.baseURL + "q=\(myCityName)" + "&appid=\(apiKey)"
        homeViewDataSource.getForeCastData(urlString: urlString) { result in
            DispatchQueue.main.async {
                self.prepareWeatherForeCastViewUIModel(forecastModel: result)
                self.completionHandler?(true)
            }
        }
    }

    func getForeCastDataWithCoordinates(latitude: String,
                                        longitude: String) {
        getModelFromDefaults()
        guard weatherForeCastViewUIModel == nil else {
            return
        }
        let urlString = endPointURLs.baseURL + "lat=\(latitude)" + "&lon=\(longitude)" + "&appid=\(apiKey)"
        homeViewDataSource.getForeCastData(urlString: urlString) { result in
            DispatchQueue.main.async {
                self.prepareWeatherForeCastViewUIModel(forecastModel: result)
                self.completionHandler?(true)
            }
        }
    }

    func prepareWeatherForeCastViewUIModel(forecastModel: ForecastModel?) {
        guard let _forecastModel = forecastModel else {
            weatherForeCastViewUIModel = nil
            return
        }
        let weatherModel = _forecastModel.weatherModel.first
        let iconId = weatherModel?.icon ?? ""
        let urlString = endPointURLs.iconBaseURL + "\(iconId).png"
        let myModel = WeatherForeCastViewUIModel(urlString: urlString,
                                                 description: weatherModel?.description ?? "",
                                                 mainModel: _forecastModel.mainModel)
        weatherForeCastViewUIModel = myModel
        saveModelInDefaults()
    }
    
    func saveModelInDefaults() {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(weatherForeCastViewUIModel)
            UserDefaults.standard.set(data, forKey: "weatherForeCastViewUIModel")
        } catch {
            print("Unable to Encode Note (\(error))")
        }
    }
    
    func getModelFromDefaults() {
        if let data = UserDefaults.standard.data(forKey: "weatherForeCastViewUIModel") {
            do {
                let decoder = JSONDecoder()
                let myModel = try decoder.decode(WeatherForeCastViewUIModel.self, from: data)
                weatherForeCastViewUIModel = myModel
            } catch {
                print("Unable to Decode Note (\(error))")
            }
        }
    }
}
