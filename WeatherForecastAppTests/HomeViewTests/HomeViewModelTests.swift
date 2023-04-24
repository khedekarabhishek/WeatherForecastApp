//
//  HomeViewModelTests.swift
//  WeatherForecastAppTests
//
//  Created by Abhishek Khedekar on 24/04/23.
//

import XCTest
@testable import WeatherForecastApp

class HomeViewModelTests: XCTestCase {
    var sut: HomeViewModel!

    override func setUp() {
        sut = HomeViewModel(homeViewDataSource: HomeViewDataSourceMock())
    }
    
    func testGetForeCastData() throws {
        sut.getForeCastData(cityName: "London")
        sut.completionHandler? = { result in
            XCTAssertTrue(result)
        }
    }
    
    func testGetForeCastDataWithCoordinates() throws {
        sut.weatherForeCastViewUIModel = nil
        sut.getForeCastDataWithCoordinates(latitude: "18.5204",
                                           longitude: "73.8567")
        sut.completionHandler? = { result in
            XCTAssertTrue(result)
        }
    }
}

