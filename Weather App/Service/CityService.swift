//
//  CityService.swift
//  Weather App
//
//  Created by Akshay  Chavan on 04/04/21.
//

import Foundation
import CoreData

struct CityService:CityServiceProtocol {
    func getAllBookmarks(completionHandler: @escaping (Result<[City], NetworkError>) -> Void) {
        CoreDataManager.sharedManager.fetchAllObjects(from: "Bookmark") { (objects) in
            getBookMarkedCitiesFromServer(bookMarked: objects) { (result) in
                
                switch result{
                    case .success(let cities):
                        completionHandler(.success(cities))
                    case .failure(let error):
                        completionHandler(.failure(error))
                        
                }
            }
        }
    }
    
    func deleteObject(for city:String,completionHandler:@escaping(Bool)->Void){
        let predicate = NSPredicate(format: "location == %@", city)
        CoreDataManager.sharedManager.fetchObject(from: "Bookmark", using: predicate) { (obj) in
            guard let managedObj = obj else{
                return
            }
            CoreDataManager.sharedManager.deleteObject(object: managedObj) {
                completionHandler(true)
            }
        }
        
    }
    
    func searchFor(city:String,completionHandler:@escaping(City,CityFiveDayForcast)->Void,errorHandler:@escaping(NetworkError)->Void){
        var cityPh:City?
        var cityFiveDayForcast:CityFiveDayForcast?
        let group = DispatchGroup()
        var isError:NetworkError?
        group.enter()
        self.searchFor(city: city) { (result) in
            group.leave()
            switch result {
                case .success(let city):
                    cityPh = city
                case .failure(let error):
                    isError = error
            }
        }
        
        group.enter()
        CityFiveDayForecastService().getFiveDayForecast(city: city) { (result) in
            group.leave()
            switch result {
                case .success(let city):
                    cityFiveDayForcast = city
                case .failure(let error):
                    isError = error
            }
        }
        
        group.notify(queue: DispatchQueue.main) {
            if isError != nil{
                errorHandler(isError!)
            }else{
                completionHandler(cityPh!,cityFiveDayForcast!)
            }
        }
    }
    
    
    private func getBookMarkedCitiesFromServer(bookMarked:[NSManagedObject],completionHandler: @escaping (Result<[City], NetworkError>) -> Void){
        DispatchQueue.global().async {
            
            var cities:[City] = []
            var networkError:NetworkError? = nil
            let semaphore = DispatchSemaphore(value: 1)
            let group = DispatchGroup()
            
            for object in bookMarked {
                group.enter()
                semaphore.wait()
                self.searchFor(city: object.value(forKey: "location") as! String) { (result) in
                    switch result {
                        case .success(let city):
                            cities.append(city)
                        case .failure(let error):
                            networkError = error
                    }
                    semaphore.signal()
                    group.leave()
                }
            }
            group.notify(queue: DispatchQueue.main) {
                if let error = networkError{
                    completionHandler(.failure(error))
                }else{
                    completionHandler(Result.success(cities))
                }
            }
        }
        
    }
    
    
    private func searchFor(city:String,completionHandler:@escaping (Result<City,NetworkError>)->Void) {
        let units = UserDefaults.standard.value(forKey: "UOM") as? String
        let originalUrlString = "\(Base_Url)data/2.5/weather?q=\(city)&appid=\(API_KEY)&units=\(units ?? "metric")"
        guard let urlString = originalUrlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            completionHandler(.failure(.badUrl))
            return
        }
        
        guard let url = URL(string: urlString) else {
            completionHandler(.failure(.badUrl))
            return
        }
        let service = Service<City>(url: url)
        service.get { (result) in
            switch result {
                case .success(let city):
                    completionHandler(.success(city))
                case .failure(let error):
                    completionHandler(.failure(error))
            }
        }
    }
}
