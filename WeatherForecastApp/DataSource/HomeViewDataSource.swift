//
//  HomeViewDataSource.swift
//  WeatherForecastApp
//
//  Created by Abhishek Khedekar on 22/04/23.
//

import Foundation

protocol HomeViewDataSourceProtocol {
    func getForeCastData(urlString: String,
                         completion : @escaping (_ result: ForecastModel?) -> Void)
}

struct HomeViewDataSource: HomeViewDataSourceProtocol {
    private let networkManager: NetworkManagerProtocol
    
    init(networkManager: NetworkManagerProtocol = NetworkManager()) {
        self.networkManager = networkManager
    }

    func getForeCastData(urlString: String,
                         completion : @escaping (_ result: ForecastModel?) -> Void) {
        guard let openURL = URL(string: urlString) else {
            fatalError("Missing URL")
        }
        let urlRequest = URLRequest(url: openURL)
        networkManager.getAPIData(urlRequest: urlRequest,
                                  resultType: ForecastModel.self,
                                  completionHandler: completion)
    }
}
