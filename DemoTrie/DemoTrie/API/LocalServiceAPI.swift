//
//  LocalServiceAPI.swift
//  DemoTrie
//
//  Created by Gaurav Tiwari on 22/06/19.
//  Copyright © 2019 Gaurav Tiwari. All rights reserved.
//

import UIKit

protocol LocalServiceAPIProtocol {
    func requestCityList(completion: @escaping (CityList?) -> ())
    func requestCityListWithPrefix(searchString: String, completion: @escaping (CityList?) -> ())
}

class LocalServiceAPI: LocalServiceAPIProtocol {
    var trie:Trie?
    var completionHandler: ((CityList?) -> ())?
    static let shared: LocalServiceAPIProtocol = LocalServiceAPI()
    private let operationQueue: OperationQueue = OperationQueue()

    func requestCityList(completion: @escaping (CityList?) -> ()) {
        DispatchQueue.global(qos: .background).async {
            if (self.trie == nil) {
                self.createTrie {(list) in
                    completion(list)
                }
            }
        }
    }
    
    func requestCityListWithPrefix(searchString: String, completion: @escaping (CityList?) -> ()) {
        operationQueue.cancelAllOperations()
        if self.trie != nil{
            let dataOperation = BackbaseDataOperation(searchString: searchString, rootTrie: self.trie!)
            dataOperation.completionBlock = {
                completion (dataOperation.list)
            }
            operationQueue.addOperations([dataOperation], waitUntilFinished: false)
        }
        
        else{
            completion(nil)
        }
    }
    

}

extension LocalServiceAPI {
    private func createTrie(completion: @escaping (CityList?) -> ()){
        self.requestCityListFromLocalFile { list in
            self.trie = Trie()
            for city in (list?.cities)! {
                self.trie?.insert(name: city.cityName, cityDetail: city)
            }
            completion(list)
        }
    }
}

extension LocalServiceAPI {
    private func requestCityListFromLocalFile(completion: @escaping (CityList?) -> ()) {
        DispatchQueue.global(qos: .background).async {
            guard let data = self.dataFromFile("cities") else {
                print("Error getting data from file")
                return
            }
            do{
                if let arrayCity = try JSONSerialization.jsonObject(with: data) as? [AnyObject] {
                    completion(CityList(citiesTemp: arrayCity))
                }
                else{
                    //DispatchQueue.main.async {
                    completion(nil)
                    //}
                }
            } catch {
                print("Error deserializing JSON: \(error)")
            }
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
