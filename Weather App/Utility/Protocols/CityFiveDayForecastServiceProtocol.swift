//
//  CityFiveDayForecastServiceProtocol.swift
//  Weather App
//
//  Created by Akshay  Chavan on 04/04/21.
//

import Foundation

protocol CityFiveDayForecastServiceProtocol {
    func getFiveDayForecast(city:String,completionHandler:@escaping (Result<CityFiveDayForcast,NetworkError>)->Void)
    func formatFiveDayForecastObjects(objects:[CityViewModel]) -> [[CityViewModel]?]
    func bookMark(city:CityViewModel,completionHandler:@escaping(_ message:String)->Void)
}
