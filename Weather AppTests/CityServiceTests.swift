//
//  CityServiceTests.swift
//  Weather AppTests
//
//  Created by Akshay  Chavan on 04/04/21.
//

import XCTest
@testable import Weather_App

class CityServiceTests: XCTestCase {
    
    //Black box tesing
    func testGetAllBookMarks(){
        let expectations = self.expectation(description: "")
        
        CityService().getAllBookmarks { (result) in
            switch result {
                case .success( _):
                    expectations.fulfill()
                case .failure(let error):
                    switch error {
                        case .offline:
                            expectations.fulfill()
                        case .badUrl:
                            XCTAssertFalse(true)
                        case .invalidJSON:
                            XCTAssertFalse(true)
                        case .noRecordsExist:
                            expectations.fulfill()
                        case .requestTimeOut:
                            XCTAssertFalse(true)
                        case .responseFailed:
                            XCTAssertFalse(true)
                            
                    }
            }
        }
        wait(for: [expectations], timeout: 5)
    }
    
    //Mock Testing
    func testGetAllBookMarkWithMockForSuccess(){
        let mockService = MockCityService()
        mockService.getAllBookmarks { (result) in
            switch result {
                case .success(let cityArray):
                    XCTAssertEqual(1, cityArray.count)
                    XCTAssertEqual(cityArray.first?.name, "Pune")
                case .failure(let error):
                    XCTAssertNotNil(error)
            }
        }
    }
    
    func testGetAllBookMarkWithMockForFailure(){
        var mockService = MockCityService()
        mockService.shouldTestForSuccess = false
        mockService.getAllBookmarks { (result) in
            switch result {
                case .success(let cityArray):
                    XCTAssertEqual(cityArray.first?.name, "Pune")
                case .failure(let error):
                    XCTAssertNotNil(error)
                    XCTAssertEqual(NetworkError.noRecordsExist, error)
                    
            }
        }
    }
    
    func testDeleteObjForSuccess(){
        let mockService = MockCityService()
        mockService.deleteObject(for: "Pune") { (flat) in
            XCTAssertTrue(flat)
        }
    }
    
    func testDeleteObjForFailure(){
        var mockService = MockCityService()
        mockService.shouldTestForSuccess = false
        mockService.deleteObject(for: "Pune") { (flat) in
            XCTAssertFalse(flat)
        }
    }
    
    func testSearchForCityForSuccess(){
        let mockService = MockCityService()
        mockService.searchFor(city: "Pune") { (city, fiveDay) in
            XCTAssertNotNil(city)
            XCTAssertNotNil(fiveDay)
            XCTAssertEqual(city.name, "Pune")
            XCTAssertEqual(fiveDay.list.count, 5)
            
        } errorHandler: { (error) in
            
        }

    }
    
    func testSearchForCityForFailure(){
        var mockService = MockCityService()
        mockService.shouldTestForSuccess = false
        mockService.searchFor(city: "Pune") { (city, fiveDay) in
        } errorHandler: { (error) in
            XCTAssertNotNil(error)
            XCTAssertEqual(NetworkError.responseFailed, error)
        }
        
    }
}
