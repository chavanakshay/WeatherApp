//
//  CityFiveDayForecastService.swift
//  Weather App
//
//  Created by Akshay  Chavan on 04/04/21.
//

import Foundation

struct CityFiveDayForecastService:CityFiveDayForecastServiceProtocol {
    
    func getFiveDayForecast(city:String,completionHandler:@escaping (Result<CityFiveDayForcast,NetworkError>)->Void){
        let units = UserDefaults.standard.value(forKey: "UOM") as? String
        let originalUrlString = "\(Base_Url)data/2.5/forecast?q=\(city)&appid=\(API_KEY)&units=\(units ?? "metric")"
        guard let urlString = originalUrlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            completionHandler(.failure(.badUrl))
            return
        }
        
        guard let url = URL(string: urlString) else {
            completionHandler(.failure(.badUrl))
            return
        }
        
        let service = Service<CityFiveDayForcast>(url: url)
        service.get { (result) in
            switch result {
                case .success(let city):
                    completionHandler(.success(city))
                case .failure(let error):
                    completionHandler(.failure(error))
            }
        }
    }
    
    func bookMark(city:CityViewModel,completionHandler:@escaping(_ message:String)->Void)  {
        
        self.isAlreadyBookMarked(city: city) { (isAlreadyBookmarked) in
            if isAlreadyBookmarked {
                completionHandler("Location is already bookmarked")
            }else{
                guard let managedObj = CoreDataManager.sharedManager.getManagedObject(for: "Bookmark") else{return}
                managedObj.setValue(city.name, forKey: "location")
                //                managedObj.setValue(city.temprature, forKey: "temprature")
                //                managedObj.setValue(city.tempratureDescription, forKey: "tempratureDesc")
                CoreDataManager.sharedManager.saveObject(object: managedObj)
                completionHandler("Location is bookmarked")
            }
        }
    }
    
    private func isAlreadyBookMarked(city:CityViewModel,completionHandler:@escaping(_ isBookmarked:Bool)->Void){
        let predicate = NSPredicate(format: "location == %@", city.name)
        CoreDataManager.sharedManager.fetchObject(from: "Bookmark", using: predicate) { (obj) in
            completionHandler(obj != nil)
        }
    }
    
    
    func formatFiveDayForecastObjects(objects:[CityViewModel]) -> [[CityViewModel]?] {
        
        let sortedObjects = objects.sorted {
            $0.dateText < $1.dateText
        }
        
        var array:[[CityViewModel]?] = []
        var listarray:[CityViewModel]? = nil
        for obj in sortedObjects {
            if(listarray == nil){
                listarray = []
                listarray?.append(obj)
            }else{
                let dateArrayFromList = listarray?.last?.dateText.components(separatedBy: " ")
                let dateArray = obj.dateText.components(separatedBy: " ")
                if dateArray.first == dateArrayFromList?.first {
                    listarray?.append(obj)
                }else{
                    array.append(listarray)
                    listarray = nil
                }
            }
        }
        
        if array.count == 0 && listarray?.count ?? 0 > 0 {
            array.append(listarray)
        }
        return array
    }
    
}
