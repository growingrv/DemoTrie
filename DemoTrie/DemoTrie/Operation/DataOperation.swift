//
//  Operation.swift
//  DemoTrie
//
//  Created by Gaurav Tiwari on 23/06/19.
//  Copyright © 2019 Gaurav Tiwari. All rights reserved.
//

import Foundation

class DataOperation: Operation {
    
    private var _executing = false {
        willSet {
            willChangeValue(forKey: "isExecuting")
        }
        didSet {
            didChangeValue(forKey: "isExecuting")
        }
    }
    
    override var isExecuting: Bool {
        return _executing
    }
    
    private var _finished = false {
        willSet {
            willChangeValue(forKey: "isFinished")
        }
        
        didSet {
            didChangeValue(forKey: "isFinished")
        }
    }
    
    override var isFinished: Bool {
        return _finished
    }
    
    func executing(_ executing: Bool) {
        _executing = executing
    }
    
    func finish(_ finished: Bool) {
        _finished = finished
    }
}

class BackbaseDataOperation : DataOperation {
    private let searchString: String
    var list: CityList?
    var rootTrie: Trie

    init (searchString : String, rootTrie: Trie){
        self.searchString = searchString
        self.rootTrie = rootTrie
    }
    
    override func main() {
        guard isCancelled == false else {
            finish(true)
            return
        }
        executing(true)
        let cityList = self.rootTrie.findCitiesWithPrefix(prefix: searchString)
        if cityList.count > 0{
            guard self.isCancelled == false else {
                self.executing(false)
                self.finish(false)
                return
            }
            self.list = CityList(citiesTemp: cityList)
            self.executing(false)
            self.finish(true)
        }
        else{
            self.executing(false)
            finish(true)
            return
        }

    }
}
