//
//  MockCityFiveDayForecastService.swift
//  Weather AppTests
//
//  Created by Akshay  Chavan on 04/04/21.
//

@testable import Weather_App

struct MockCityFiveDayForecastService:CityFiveDayForecastServiceProtocol {
    var shouldTestForSuccess = true
    
    func getFiveDayForecast(city: String, completionHandler: @escaping (Result<CityFiveDayForcast, NetworkError>) -> Void) {
        if shouldTestForSuccess {
            let weather = Weather(id: 1, main: "Clear", weatherDescription: "description", icon: "icon")
            let mainObj = Main(temp: 29, feelsLike: 30, humidity: 15)
            let wind = Wind(speed: 30, deg: 20)
            let cloud = Clouds(all: 8)
            
            let list1 = List(dt: 9, main: mainObj, weather: [weather], clouds: cloud, wind: wind, visibility: 20, dtTxt: "13-23-2021 344:333:322")
            let list2 = List(dt: 9, main: mainObj, weather: [weather], clouds: cloud, wind: wind, visibility: 20, dtTxt: "13-23-2021 344:333:322")
            let list3 = List(dt: 9, main: mainObj, weather: [weather], clouds: cloud, wind: wind, visibility: 20, dtTxt: "13-23-2021 344:333:322")
            let list4 = List(dt: 9, main: mainObj, weather: [weather], clouds: cloud, wind: wind, visibility: 20, dtTxt: "13-23-2021 344:333:322")
            let list5 = List(dt: 9, main: mainObj, weather: [weather], clouds: cloud, wind: wind, visibility: 20, dtTxt: "13-23-2021 344:333:322")
            let fiveday = CityFiveDayForcast(cod: "200", message: 2, cnt: 3, list: [list1,list2,list3,list4,list5])
            completionHandler(.success(fiveday))
        }else{
            completionHandler(.failure(.responseFailed))
        }
    }
    
    func formatFiveDayForecastObjects(objects: [CityViewModel]) -> [[CityViewModel]?] {
        return [nil]
    }
    
    func bookMark(city: CityViewModel, completionHandler: @escaping (String) -> Void) {
        if shouldTestForSuccess {
            completionHandler("Location is bookmarked")
        }else{
            completionHandler("Location is already bookmarked")
        }
    }
    
    
}
