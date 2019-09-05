//
//  CityTableViewControllerTest.swift
//  DemoTrieUITests
//
//  Created by Gaurav Tiwari on 23/06/19.
//  Copyright © 2019 Gaurav Tiwari. All rights reserved.
//

import XCTest
@testable import DemoTrie

class CityTableViewControllerTest: XCTestCase {
    
    func testViewModel(){
        let storyboardBundle = Bundle(for: CityTableViewController.self)
        let storyboard = UIStoryboard(name: "Main", bundle: storyboardBundle)
        let viewController = storyboard.instantiateViewController(withIdentifier: "CityTableViewController") as! CityTableViewController
        viewController.loadView()
        XCTAssertNotNil(viewController.viewModel, "viewModel is not initialized properly")
    }
    
    func testDataSource(){
        let storyboardBundle = Bundle(for: CityTableViewController.self)
        let storyboard = UIStoryboard(name: "Main", bundle: storyboardBundle)
        let viewController = storyboard.instantiateViewController(withIdentifier: "CityTableViewController") as! CityTableViewController
        viewController.loadView()
        XCTAssertNotNil(viewController.dataSource, "dataSource is not initialized properly")
    }
    
    func testListTableView() {
        let storyboardBundle = Bundle(for: CityTableViewController.self)
        let storyboard = UIStoryboard(name: "Main", bundle: storyboardBundle)
        let viewController = storyboard.instantiateViewController(withIdentifier: "CityTableViewController") as! CityTableViewController
        viewController.viewDidLoad()
        
        XCTAssertNotNil(viewController.citiesTableView, "Table is not initialized properly")
        XCTAssert((viewController.citiesTableView.dataSource?.isEqual(viewController.dataSource))!, "Table datasource not initialized properly")
    }

}
