//
//  ViewController.swift
//  WeatherForecastApp
//
//  Created by Abhishek Khedekar on 22/04/23.
//

import UIKit
import SwiftUI
import CoreLocation

class HomeViewController: UIViewController {
    @ObservedObject private var homeViewModel = HomeViewModel()
    let locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLocationManager()
        addWeatherForeCastView()
    }
    
    private func setupLocationManager() {
        // Need to select "City run" in simulator in Features -> Location to display data 
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }

    private func addWeatherForeCastView() {
        let viewController = UIHostingController(
            rootView: WeatherForeCastView(
                viewModel: homeViewModel))
        let weatherForecastView = viewController.view!
        weatherForecastView.translatesAutoresizingMaskIntoConstraints = false
        addChild(viewController)
        view.addSubview(weatherForecastView)
        NSLayoutConstraint.activate([
            weatherForecastView.topAnchor.constraint(equalTo: view.topAnchor),
            weatherForecastView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            weatherForecastView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            weatherForecastView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        viewController.didMove(toParent: self)
    }
}

extension HomeViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locationManager.stopUpdatingLocation()
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        homeViewModel.getForeCastDataWithCoordinates(latitude: String(locValue.latitude),
                                                     longitude: String(locValue.longitude))
    }
}
