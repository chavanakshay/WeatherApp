//
//  CityFiveDayForecastServiceTest.swift
//  Weather AppTests
//
//  Created by Akshay  Chavan on 04/04/21.
//

import XCTest
@testable import Weather_App

class CityFiveDayForecastServiceTest: XCTestCase {

    func testGetFiveDayForecastForSuccess(){
        let mockService = MockCityFiveDayForecastService()
        mockService.getFiveDayForecast(city: "Pune") { (result) in
            switch result{
                case .success(let fiveDayForecast):
                    XCTAssertNotNil(fiveDayForecast)
                    XCTAssertEqual(fiveDayForecast.list.count, 5)
                    XCTAssertEqual(fiveDayForecast.list.first?.wind.speed, 30)
                case .failure(_):
                    XCTAssert(true)
            }
        }
    }
    
    func testGetFiveDayForecastForFailure(){
        var mockService = MockCityFiveDayForecastService()
        mockService.shouldTestForSuccess = false
        mockService.getFiveDayForecast(city: "Pune") { (result) in
            switch result{
                case .success(let fiveDayForecast):
                    XCTAssertNotNil(fiveDayForecast)
                    XCTAssertEqual(fiveDayForecast.list.count, 5)
                    XCTAssertEqual(fiveDayForecast.list.first?.wind.speed, 30)
                case .failure(let error):
                    XCTAssertEqual(error.getMessage, "City not found.")
            }
        }
    }
    
    func testFormatFiveDayObjects(){
        let service = CityFiveDayForecastService()
        let weather = Weather(id: 1, main: "Clear", weatherDescription: "description", icon: "icon")
        let mainObj = Main(temp: 29, feelsLike: 30, humidity: 15)
        let wind = Wind(speed: 30, deg: 20)
        let cloud = Clouds(all: 8)
        
        let list1 = List(dt: 9, main: mainObj, weather: [weather], clouds: cloud, wind: wind, visibility: 20, dtTxt: "13-23-2021 344:333:322")
        let list2 = List(dt: 9, main: mainObj, weather: [weather], clouds: cloud, wind: wind, visibility: 20, dtTxt: "13-23-2021 344:333:322")
        let list3 = List(dt: 9, main: mainObj, weather: [weather], clouds: cloud, wind: wind, visibility: 20, dtTxt: "13-23-2021 344:333:322")
        let list4 = List(dt: 9, main: mainObj, weather: [weather], clouds: cloud, wind: wind, visibility: 20, dtTxt: "13-23-2021 344:333:322")
        let list5 = List(dt: 9, main: mainObj, weather: [weather], clouds: cloud, wind: wind, visibility: 20, dtTxt: "13-23-2021 344:333:322")
        
        let model1 = CityViewModel(city: list1)
        let model2 = CityViewModel(city: list2)
        let model3 = CityViewModel(city: list3)
        let model4 = CityViewModel(city: list4)
        let model5 = CityViewModel(city: list5)

        let cityViewModelArray = service.formatFiveDayForecastObjects(objects: [model1,model2,model3,model4,model5])
        
        XCTAssertEqual(cityViewModelArray.count, 1)
    }
    
    func testBookMarkForSuccess(){
        let mockService = MockCityFiveDayForecastService()
        
        let weather = Weather(id: 1, main: "Clear", weatherDescription: "description", icon: "icon")
        let mainObj = Main(temp: 29, feelsLike: 30, humidity: 15)
        let wind = Wind(speed: 30, deg: 20)
        let cloud = Clouds(all: 8)
        let list1 = List(dt: 9, main: mainObj, weather: [weather], clouds: cloud, wind: wind, visibility: 20, dtTxt: "13-23-2021 344:333:322")

        let model1 = CityViewModel(city: list1)

        mockService.bookMark(city: model1) { (response) in
            XCTAssertEqual(response, "Location is bookmarked")
        }
    }
    
    func testBookMarkForFailure(){
        var mockService = MockCityFiveDayForecastService()
        mockService.shouldTestForSuccess = false
        let weather = Weather(id: 1, main: "Clear", weatherDescription: "description", icon: "icon")
        let mainObj = Main(temp: 29, feelsLike: 30, humidity: 15)
        let wind = Wind(speed: 30, deg: 20)
        let cloud = Clouds(all: 8)
        let list1 = List(dt: 9, main: mainObj, weather: [weather], clouds: cloud, wind: wind, visibility: 20, dtTxt: "13-23-2021 344:333:322")
        
        let model1 = CityViewModel(city: list1)
        
        mockService.bookMark(city: model1) { (response) in
            XCTAssertEqual(response, "Location is already bookmarked")
        }
    }
}
