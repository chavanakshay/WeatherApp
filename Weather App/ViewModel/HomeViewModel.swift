//
//  HomeViewModel.swift
//  Weather App
//
//  Created by Akshay  Chavan on 04/04/21.
//

import Foundation

struct HomeViewModel {
    private let cityService:CityService

    
    init(cityService:CityService) {
        self.cityService = cityService
    }
    
    func reloadBookMarks(completionHandler:@escaping([CityViewModel])->Void, errorHandler:@escaping(NetworkError)->Void){
        cityService.getAllBookmarks { (result) in
            switch result {
                case .success(let cities):
                    let cities = cities.map({ (city) -> CityViewModel in
                        CityViewModel(city: city)
                    })
                    completionHandler(cities)
                case .failure(let error):
                    errorHandler(error)
            }
        }
    }
    
    func searchCityDetails(for city:String,completionHandler:@escaping(CityViewModel,[CityViewModel])->Void, errorHandler:@escaping(NetworkError)->Void){
        cityService.searchFor(city: city) {(city, fiveDayForecast) in
            let fiveDaysDetails = fiveDayForecast.list.map { (obj) -> CityViewModel in
                CityViewModel(city: obj)
            }
            completionHandler(CityViewModel(city: city),fiveDaysDetails)
        } errorHandler: {(error) in
            errorHandler(error)
        }
    }
    
}
