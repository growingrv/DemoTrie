//
//  City.swift
//  DemoTrie
//
//  Created by Gaurav Tiwari on 21/06/19.
//  Copyright © 2019 Gaurav Tiwari. All rights reserved.
//

import UIKit

struct City {
    var cityName : String
    var cityCountryName : String
    var cityCoordinates : CityCoordinates = CityCoordinates (latitude: 0.0, longitude: 0.0)
    
    init?(dictCity: Dictionary<String, AnyObject>) {
        self.cityName = dictCity["name"] as? String ?? ""
        self.cityCountryName = dictCity["country"] as? String ?? ""
        if let coord = dictCity["coord"] as? Dictionary<String, AnyObject>{
            self.cityCoordinates = getCoordinate(coordinate: coord)
        }
    }
}

struct CityList {
    var cities = [City]()
    init(citiesTemp: Array<AnyObject>) {
        cities = citiesTemp.compactMap(){dict in
            if let typeDict = dict as? Dictionary<String,AnyObject>{
                return City(dictCity: typeDict)
            } else {
                return nil
            }
        }
    }
    init(citiesTemp: Array<City>) {
        self.cities = citiesTemp
    }
}

extension City{
    func getCoordinate(coordinate: Dictionary<String,AnyObject>) -> CityCoordinates {
        let  coordinate = CityCoordinates(latitude: coordinate["lat"] as? Double ?? 0.0, longitude: coordinate["lon"] as? Double ?? 0.0)
        return coordinate
    }
}

struct CityCoordinates {
    let latitude : Double
    let longitude : Double
}
