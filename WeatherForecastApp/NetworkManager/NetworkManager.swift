//
//  File.swift
//  WeatherForecastApp
//
//  Created by Abhishek Khedekar on 22/04/23.
//

import Foundation

let apiKey = "5e34d49a4030243e62ac964ab7d44416"

struct Constants {
    static let ErrorAlertTitle = "Error"
    static let OkAlertTitle = "Ok"
    static let CancelAlertTitle = "Cancel"
}

struct endPointURLs {
    static let baseURL = "https://api.openweathermap.org/data/2.5/weather?"
    static let iconBaseURL = "https://openweathermap.org/img/wn/"
}

protocol NetworkManagerProtocol {
    func getAPIData<T: Decodable>(urlRequest: URLRequest,
                                  resultType: T.Type,
                                  completionHandler: @escaping(_ result: T?)-> Void)
}

struct NetworkManager: NetworkManagerProtocol {
    func getAPIData<T: Decodable>(urlRequest: URLRequest,
                                  resultType: T.Type,
                                  completionHandler: @escaping(_ result: T?)-> Void) {
        URLSession.shared.dataTask(with: urlRequest) { (responseData, httpUrlResponse, error) in
            if(error == nil && responseData != nil && responseData?.count != 0) {
                let decoder = JSONDecoder()
                do {
                    let result = try decoder.decode(T.self, from: responseData!)
                    print("success")
                    completionHandler(result)
                }
                catch let error{
                    completionHandler(nil)
                    debugPrint("error occurred while decoding = \(error.localizedDescription)")
                }
            }
        }.resume()        
    }
}
