//
//  CityTableViewModel.swift
//  DemoTrie
//
//  Created by Gaurav Tiwari on 21/06/19.
//  Copyright © 2019 Gaurav Tiwari. All rights reserved.
//

import UIKit

class CityTableViewModel: NSObject {
    var dataSource = CityTableViewDataSource()
    var apiService : LocalServiceAPIProtocol

    var cities = [City]()

    init(dataSource: CityTableViewDataSource, apiService: LocalServiceAPIProtocol) {
        self.dataSource = dataSource
        self.apiService = apiService
    }
    
    func getCityList(completion : @escaping () -> ()){
        if (cities.count > 0){
            dataSource.cities = cities
            completion()
            return
        }
        
        apiService.requestCityList(completion: { [weak self] citiesList in
            self?.cities = citiesList?.cities ?? []
            let sortedArray = self?.cities.sorted {
                $0.cityName < $1.cityName
            }
            self?.cities = sortedArray ?? []
            self?.dataSource.cities = self?.cities ?? []
            completion()
        })
    }
    
    func getCityListListWithWithSearchText(searchString : String, completion : @escaping () -> ()) {
        apiService.requestCityListWithPrefix(searchString: searchString, completion: { [weak self] citiesList in
            self?.dataSource.cities = citiesList?.cities ?? []
            completion()
        })
    }
    
    func openMap(for segue: UIStoryboardSegue, indexPath: NSIndexPath){
        if let mapVC = segue.destination as? CityMapViewController{
            let city = self.dataSource.cities[indexPath.row]
            mapVC.city = city
        }
    }
}
