//
//  CityServiceProtocol.swift
//  Weather App
//
//  Created by Akshay  Chavan on 31/03/21.
//

import Foundation

protocol CityServiceProtocol {
    func getAllBookmarks(completionHandler: @escaping (Result<[City], NetworkError>) -> Void)
    func deleteObject(for city:String,completionHandler:@escaping(Bool)->Void)
    func searchFor(city:String,completionHandler:@escaping(City,CityFiveDayForcast)->Void,errorHandler:@escaping(NetworkError)->Void)
}
