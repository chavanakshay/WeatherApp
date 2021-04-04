//
//  CityFiveDayForcast.swift
//  Weather App
//
//  Created by Akshay  Chavan on 01/04/21.
//

import Foundation

// MARK: - CityFiveDayForcast
struct CityFiveDayForcast: Codable {
    let cod: String
    let message, cnt: Int
    let list: [List]
}

// MARK: - List
struct List: Codable {
    let dt: Int
    let main: Main
    let weather: [Weather]
    let clouds: Clouds
    let wind: Wind
    let visibility:Int
    let dtTxt: String
    
    enum CodingKeys: String, CodingKey {
        case dt,visibility,wind,clouds,weather,main
        case dtTxt = "dt_txt"
    }
}

