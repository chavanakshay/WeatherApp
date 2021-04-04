//
//  HomeViewModelTests.swift
//  Weather AppTests
//
//  Created by Akshay  Chavan on 04/04/21.
//
import XCTest
@testable import Weather_App

class HomeViewModelTests: XCTestCase {

    func testHomeViewModelreloadBookMarks(){
        let expectation = self.expectation(description: "Should either return result or should fail")
        let homeViewModel = HomeViewModel(cityService: CityService())
        homeViewModel.reloadBookMarks { (cityArray) in
            expectation.fulfill()
        } errorHandler: { (error) in
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5)
    }
    
    func testHomeViewModelSearchForCity(){
        let expectation = self.expectation(description: "should return the searched city")
        let homeViewModel = HomeViewModel(cityService: CityService())
        homeViewModel.searchCityDetails(for: "Pune") { (city, fivedayDetails) in
            XCTAssertEqual("Pune", city.name)
            XCTAssertNotNil(fivedayDetails)
            expectation.fulfill()
        } errorHandler: { (error) in
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5)
    }
}
