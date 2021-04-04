//
//  City.swift
//  Weather App
//
//  Created by Akshay  Chavan on 30/03/21.
//

import Foundation

// MARK: - City
struct City: Codable {
//    let coord: Coord
    let weather: [Weather]
    let base: String
    let main: Main
    let visibility: Int
    let wind: Wind
    let clouds: Clouds
    let dt: Int
//    let sys: Sys
    let timezone, id: Int
    let name: String
    let cod: Int
    
}

// MARK: - Clouds
struct Clouds: Codable {
    let all: Int
}

//// MARK: - Coord
//struct Coord: Codable {
//    let lon, lat: Double
//}

// MARK: - Main
struct Main: Codable {
    let temp, feelsLike: Double
    let humidity: Int
    
    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case humidity
    }
}

//// MARK: - Sys
//struct Sys: Codable {
//    let country: String
//    let sunrise, sunset: Int
//}

// MARK: - Weather
struct Weather: Codable {
    let id: Int
    let main, weatherDescription, icon: String
    
    enum CodingKeys: String, CodingKey {
        case id, main
        case weatherDescription = "description"
        case icon
    }
}

// MARK: - Wind
struct Wind: Codable {
    let speed: Double
    let deg: Int
//    let gust: Double
}

