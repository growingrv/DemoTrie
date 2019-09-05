//
//  LocalServiceAPITest.swift
//  DemoTrieTests
//
//  Created by Gaurav Tiwari on 23/06/19.
//  Copyright © 2019 Gaurav Tiwari. All rights reserved.
//

import XCTest
@testable import DemoTrie

class LocalServiceAPITest: XCTestCase {

    func testAPITest() {
        let mockObject = MockDefaultAPI()
        mockObject.requestCityListWithPrefix(searchString: "", completion: { (list) in
            XCTAssert(mockObject.requestCityListWithPrefixCalled, "requestCityListWithPrefix should have been called")
        })
        
        mockObject.requestCityList { (list) in
            XCTAssert(mockObject.requestAllCityListCalled, "requestAllCityList should have been called")
        }
    }

    func testGetCityAPIWithPrefix() {
        let expectation = XCTestExpectation(description: "load citylist")
        LocalServiceAPI.shared.requestCityListWithPrefix(searchString: "Ab") { list in
            XCTAssertNil(list, "Data should be nil if someone call this API before requestAllCity API finished")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
}

class MockDefaultAPI: NSObject, LocalServiceAPIProtocol {
    var requestAllCityListCalled = false
    var requestCityListWithPrefixCalled = false
    
    func requestCityList(completion: @escaping (CityList?) -> ()){
        self.requestAllCityListCalled = true;
    }
    
    func requestCityListWithPrefix(searchString: String, completion: @escaping (CityList?) -> ()){
        self.requestCityListWithPrefixCalled = true;
    }
}

