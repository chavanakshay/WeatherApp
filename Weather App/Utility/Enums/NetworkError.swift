//
//  NetworkError.swift
//  Weather App
//
//  Created by Akshay  Chavan on 01/04/21.
//

import Foundation

enum NetworkError:Error {
    case responseFailed
    case noRecordsExist
    case invalidJSON
    case badUrl
    case offline
    case requestTimeOut
    
    var getMessage:String{
        get{
            switch self {
                case .responseFailed:
                    return "City not found."
                case .noRecordsExist:
                    return "No records exist."
                case .invalidJSON:
                    return "Invalid JSON format. Contact server team."
                case .badUrl:
                    return "Bad URL. Please check the request."
                case .offline:
                    return offlineErrorMessage
                case .requestTimeOut:
                    return "Request timeout. Please try again."
            }
        }
    }
}
