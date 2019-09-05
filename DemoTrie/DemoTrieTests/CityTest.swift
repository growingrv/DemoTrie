//
//  CityTest.swift
//  DemoTrieTests
//
//  Created by Gaurav Tiwari on 23/06/19.
//  Copyright © 2019 Gaurav Tiwari. All rights reserved.
//

import XCTest
@testable import DemoTrie

class CityTest: XCTestCase {
    var cityList = [AnyObject]()
    override func setUp() {
        guard let data = self.dataFromFile("cities") else {
            print("Error getting data from file")
            return
        }
        do{
            if let arrayCity = try JSONSerialization.jsonObject(with: data) as? [AnyObject] {
                self.cityList = arrayCity
            }
        } catch {
            print("Error deserializing JSON: \(error)")
        }
    }
        
    func testCityList() {
        let cities = CityList(citiesTemp: self.cityList)
        let city = cities.cities.first
        
        let coord = city?.cityCoordinates
        
        XCTAssertNotNil(cities.cities,"cities should not be nil")
        
        XCTAssertNotNil(city,"city should not be nil")
        XCTAssertTrue(city?.cityName == "Hurzuf")
        XCTAssertTrue(city?.cityCountryName == "UA")
        
        XCTAssertNotNil(coord,"coord should not be nil")
        XCTAssertTrue(coord?.latitude == 44.549999)
        XCTAssertTrue(coord?.longitude == 34.283333)
        
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    private func dataFromFile(_ filename: String) -> Data? {
        if let path = Bundle.main.path(forResource: filename, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                return data
            } catch {
                // handle error
            }
        }
        return nil
    }
    
}
