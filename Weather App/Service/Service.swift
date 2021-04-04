//
//  Service.swift
//  Weather App
//
//  Created by Akshay  Chavan on 01/04/21.
//

import Foundation

class Service<T:Decodable> {
    var session: URLSession
    var url: URL
    
    init(url:URL,session:URLSession = URLSession.shared) {
        self.url = url
        self.session = session
    }
    
    func get(completionHandler: @escaping (Result<T, NetworkError>) -> Void) {
       let task = session.dataTask(with: url) { (data, response, error) in
            
            if let error:NSError = error as NSError? {
                if error.code == -1009 {
                    completionHandler(Result.failure(.offline))
                }else if error.code == -1001 {
                    completionHandler(Result.failure(.requestTimeOut))
                }else{
                    completionHandler(Result.failure(.responseFailed))
                }
                return
            }
        
        if let urlResponse:HTTPURLResponse = response as? HTTPURLResponse{
            if urlResponse.statusCode == 404 {
                completionHandler(Result.failure(.responseFailed))
                return
            }
        }
            
            guard let responseData = data else{
                completionHandler(Result.failure(.noRecordsExist))
                return
            }
            
            let decoder = JSONDecoder()
            do{
                let resultantObj = try decoder.decode(T.self, from: responseData)
                completionHandler(Result.success(resultantObj))
            }catch{
                completionHandler(Result.failure(.invalidJSON))
            }
        }
        task.resume()
    }
}
