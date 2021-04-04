//
//  MockCityService.swift
//  Weather AppTests
//
//  Created by Akshay  Chavan on 04/04/21.
//

@testable import Weather_App

struct MockCityService:CityServiceProtocol {
    var shouldTestForSuccess = true
    
    func getAllBookmarks(completionHandler: @escaping (Result<[City], NetworkError>) -> Void){
        if shouldTestForSuccess {
            let weather = Weather(id: 1, main: "Clear", weatherDescription: "description", icon: "icon")
            let mainObj = Main(temp: 29, feelsLike: 30, humidity: 15)
            let wind = Wind(speed: 30, deg: 20)
            let cloud = Clouds(all: 8)
            let city = City(weather: [weather], base: "base", main: mainObj, visibility: 20, wind: wind, clouds: cloud, dt: 3, timezone: 4, id: 2, name: "Pune", cod: 400)
            completionHandler(.success([city]))
        }else{
            completionHandler(.failure(.noRecordsExist))
        }
    }
    func deleteObject(for city:String,completionHandler:@escaping(Bool)->Void){
        completionHandler(shouldTestForSuccess)
    }
    func searchFor(city:String,completionHandler:@escaping(City,CityFiveDayForcast)->Void,errorHandler:@escaping(NetworkError)->Void){
        
        if shouldTestForSuccess {
            let weather = Weather(id: 1, main: "Clear", weatherDescription: "description", icon: "icon")
            let mainObj = Main(temp: 29, feelsLike: 30, humidity: 15)
            let wind = Wind(speed: 30, deg: 20)
            let cloud = Clouds(all: 8)
            let city = City(weather: [weather], base: "base", main: mainObj, visibility: 20, wind: wind, clouds: cloud, dt: 3, timezone: 4, id: 2, name: "Pune", cod: 400)
            

            
            let list1 = List(dt: 9, main: mainObj, weather: [weather], clouds: cloud, wind: wind, visibility: 20, dtTxt: "13-23-2021 344:333:322")
            let list2 = List(dt: 9, main: mainObj, weather: [weather], clouds: cloud, wind: wind, visibility: 20, dtTxt: "13-23-2021 344:333:322")
            let list3 = List(dt: 9, main: mainObj, weather: [weather], clouds: cloud, wind: wind, visibility: 20, dtTxt: "13-23-2021 344:333:322")
            let list4 = List(dt: 9, main: mainObj, weather: [weather], clouds: cloud, wind: wind, visibility: 20, dtTxt: "13-23-2021 344:333:322")
            let list5 = List(dt: 9, main: mainObj, weather: [weather], clouds: cloud, wind: wind, visibility: 20, dtTxt: "13-23-2021 344:333:322")
            let fiveday = CityFiveDayForcast(cod: "200", message: 2, cnt: 3, list: [list1,list2,list3,list4,list5])
            
            completionHandler(city,fiveday)
        }else{
            errorHandler(.responseFailed)
        }
    }
}
