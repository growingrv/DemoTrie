//
//  TrieTest.swift
//  DemoTrieTests
//
//  Created by Gaurav Tiwari on 23/06/19.
//  Copyright © 2019 Gaurav Tiwari. All rights reserved.
//

import XCTest
@testable import DemoTrie

class TrieTest: XCTestCase {
    
    var cityList: CityList?
    var city: City?
    var trie = Trie()
    override func setUp() {
        city = City(dictCity: ["name":"test" as AnyObject,"country":"india" as AnyObject,"coord":["lat":32.00,"lon":45.00] as AnyObject])
    }
    
    func testInsert() {
        let trie = Trie()
        trie.insert(name: "bangalore", cityDetail: city!)
        trie.insert(name: "jabalpur", cityDetail: city!)
        trie.insert(name: "raipur", cityDetail: city!)
        XCTAssertTrue(trie.contains(name: "bangalore"))
        XCTAssertFalse(trie.contains(name: "bangalo"))
        trie.insert(name: "jaipur", cityDetail: city!)
        XCTAssertTrue(trie.contains(name: "jaipur"))
    }
    
    func testFindWordsWithPrefix() {
        let trie = Trie()
        city = City(dictCity: ["name":"Bangalore" as AnyObject,"country":"India" as AnyObject,"coord":["lat":32.00,"lon":45.00] as AnyObject])
        trie.insert(name: "Bangalore", cityDetail: city!)
        
        city = City(dictCity: ["name":"Delhi" as AnyObject,"country":"India" as AnyObject,"coord":["lat":32.00,"lon":45.00] as AnyObject])
        trie.insert(name: "Delhi", cityDetail: city!)
        
        city = City(dictCity: ["name":"Jabalpur" as AnyObject,"country":"India" as AnyObject,"coord":["lat":32.00,"lon":45.00] as AnyObject])
        trie.insert(name: "Jabalpur", cityDetail: city!)
        
        city = City(dictCity: ["name":"Pune" as AnyObject,"country":"India" as AnyObject,"coord":["lat":32.00,"lon":45.00] as AnyObject])
        trie.insert(name: "Pune", cityDetail: city!)
        var allCities = trie.findCitiesWithPrefix(prefix: "")
        XCTAssertEqual(allCities.count, 4)
        
        allCities  = trie.findCitiesWithPrefix(prefix: "pune")
        XCTAssertEqual(allCities[0].cityName, "Pune")
        XCTAssertEqual(allCities.count, 1)
        
        city = City(dictCity: ["name":"hydrabad" as AnyObject,"country":"India" as AnyObject,"coord":["lat":32.00,"lon":45.00] as AnyObject])
        trie.insert(name: "hydrabad", cityDetail: city!)
        allCities = trie.findCitiesWithPrefix(prefix: "Hydr")
        XCTAssertEqual(allCities[0].cityName, "hydrabad")
        
        city = City(dictCity: ["name":"Jaipur" as AnyObject,"country":"India" as AnyObject,"coord":["lat":32.00,"lon":45.00] as AnyObject])
        
        trie.insert(name: "Jaipur", cityDetail: city!)
        allCities = trie.findCitiesWithPrefix(prefix: "J")
        
        XCTAssertEqual(allCities.count, 2)
        allCities = trie.findCitiesWithPrefix(prefix: "xyz")
        XCTAssertEqual(allCities.count, 0)
        
    }
    
    func testContains(){
        let trie = Trie()
        trie.insert(name: "bangalore", cityDetail: city!)
        trie.insert(name: "jabal", cityDetail: city!)
        XCTAssertTrue(trie.contains(name: "bangalore"))
        XCTAssertTrue(trie.contains(name: "jabal"))
        
        trie.remove(name: "jabal")
        XCTAssertFalse(trie.contains(name: "jabal"))
    }
    func testTrieCount() {
        let trie = Trie()
        trie.insert(name: "bangalore", cityDetail: city!)
        trie.insert(name: "jabalpur", cityDetail: city!)
        trie.insert(name: "raipur", cityDetail: city!)
        XCTAssertEqual(trie.count, 3)
    }
    
}
