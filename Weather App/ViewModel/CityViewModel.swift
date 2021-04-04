//
//  CityViewModel.swift
//  Weather App
//
//  Created by Akshay  Chavan on 04/04/21.
//

import Foundation
import CoreData
import UIKit

struct CityViewModel {
    let name:String
    let temprature:String
    let weatherInfoImage:UIImage
    let imageDescription:String
    let dateText:String
    let tempratureDescription:String
    let wind:String
    let humidity:String
    let raintChances:String
    
    init(city:City) {
        self.name = city.name
        self.temprature = "\(city.main.temp)"
        self.imageDescription = city.weather.first?.weatherDescription ?? ""
        self.dateText = "Today"
        self.tempratureDescription = "Feels like \(city.main.feelsLike)°"
        self.wind = "\(city.wind.speed) km/h"
        self.humidity = "\(city.main.humidity)%"
        self.raintChances = "\(city.clouds.all)%"
        switch city.weather.first?.main {
            case "Clear":
                weatherInfoImage = UIImage(systemName: "sun.max")!
            case "Haze":
                weatherInfoImage = UIImage(systemName: "sun.haze")!
            default:
                weatherInfoImage = UIImage(systemName: "cloud")!
        }
    }
    
    init(city:List) {
        self.name = ""
        self.temprature = "\(city.main.temp)"
        self.imageDescription = city.weather.first?.weatherDescription ?? ""
        self.dateText = city.dtTxt
        self.tempratureDescription = "Feels like \(city.main.feelsLike)°"
        self.wind = "\(city.wind.speed) km/h"
        self.humidity = "\(city.main.humidity)%"
        self.raintChances = "\(city.clouds.all)%"
        switch city.weather.first?.main {
            case "Clear":
                weatherInfoImage = UIImage(systemName: "sun.max")!
            case "Haze":
                weatherInfoImage = UIImage(systemName: "sun.haze")!
            default:
                weatherInfoImage = UIImage(systemName: "cloud")!
        }
    }
    
}

