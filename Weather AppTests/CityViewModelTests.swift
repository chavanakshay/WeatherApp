//
//  CityViewModelTests.swift
//  Weather AppTests
//
//  Created by Akshay  Chavan on 04/04/21.
//

import XCTest
@testable import Weather_App

class CityViewModelTests: XCTestCase {

    func testCityViewModelForCity()  {
        let weather = Weather(id: 1, main: "Clear", weatherDescription: "description", icon: "icon")
        let mainObj = Main(temp: 29, feelsLike: 30, humidity: 15)
        let wind = Wind(speed: 30, deg: 20)
        let cloud = Clouds(all: 8)
        let city = City(weather: [weather], base: "base", main: mainObj, visibility: 20, wind: wind, clouds: cloud, dt: 3, timezone: 4, id: 2, name: "Pune", cod: 400)
        let cityViewModel = CityViewModel(city: city)
        
        XCTAssertEqual(cityViewModel.name, "Pune")
        XCTAssertEqual(cityViewModel.temprature, "\(city.main.temp)")
        XCTAssertEqual(cityViewModel.imageDescription, city.weather.first?.weatherDescription)
        XCTAssertEqual(cityViewModel.dateText, "Today")
        XCTAssertEqual(cityViewModel.tempratureDescription, "Feels like \(city.main.feelsLike)°")
        XCTAssertEqual(cityViewModel.wind, "\(city.wind.speed) km/h")
        XCTAssertEqual(cityViewModel.humidity, "\(city.main.humidity)%")
        XCTAssertEqual(cityViewModel.raintChances, "\(city.clouds.all)%")
        XCTAssertEqual(cityViewModel.weatherInfoImage, UIImage(systemName: "sun.max")!)
        
    }
    
    func testCityViewModelForList()  {
        let mainObj = Main(temp: 29, feelsLike: 30, humidity: 15)
        let weather = Weather(id: 1, main: "Clear", weatherDescription: "description", icon: "icon")
        let cloud = Clouds(all: 8)
        let wind = Wind(speed: 30, deg: 20)

        let city = List(dt: 9, main: mainObj, weather: [weather], clouds: cloud, wind: wind, visibility: 20, dtTxt: "13-23-2021 344:333:322")
        let cityViewModel = CityViewModel(city: city)
        
        XCTAssertEqual(cityViewModel.name, "")
        XCTAssertEqual(cityViewModel.temprature, "\(city.main.temp)")
        XCTAssertEqual(cityViewModel.imageDescription, city.weather.first?.weatherDescription)
        XCTAssertEqual(cityViewModel.dateText, city.dtTxt)
        XCTAssertEqual(cityViewModel.tempratureDescription, "Feels like \(city.main.feelsLike)°")
        XCTAssertEqual(cityViewModel.wind, "\(city.wind.speed) km/h")
        XCTAssertEqual(cityViewModel.humidity, "\(city.main.humidity)%")
        XCTAssertEqual(cityViewModel.raintChances, "\(city.clouds.all)%")
        XCTAssertEqual(cityViewModel.weatherInfoImage, UIImage(systemName: "sun.max")!)
    }
}
