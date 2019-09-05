//
//  CityTableViewDataSource.swift
//  DemoTrie
//
//  Created by Gaurav Tiwari on 22/06/19.
//  Copyright © 2019 Gaurav Tiwari. All rights reserved.
//

import UIKit

class CityTableViewDataSource: NSObject, UITableViewDataSource {
    var cities = [City]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CityCell", for: indexPath)
        let city : City = cities[indexPath.row]
        cell.textLabel?.text = city.cityName + ", " + city.cityCountryName
        cell.detailTextLabel?.text = String(city.cityCoordinates.latitude) + " " + String(city.cityCoordinates.longitude)
        return cell
    }
}
