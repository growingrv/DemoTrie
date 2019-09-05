//
//  Trie.swift
//  DemoTrie
//
//  Created by Gaurav Tiwari on 22/06/19.
//  Copyright © 2019 Gaurav Tiwari. All rights reserved.
//

import UIKit

class Trie: NSObject {
    typealias Node = TrieNode <Character>
    public var count: Int {
        return totalCount
    }
    public var isEmpty: Bool {
        return totalCount == 0
    }
    var cityDict = [City]()
    public var cities: ([String],[City]) {
        return citiesInSubtrie(rootNode: root, partialWord: "")
    }
    fileprivate let root: Node
    fileprivate var totalCount: Int
    
    override init() {
        root = Node()
        totalCount = 0
        super.init()
    }
}

class TrieNode <T: Hashable> {
    var value: T?
    weak var parentNode: TrieNode?
    var children: [T: TrieNode] = [:]
    var isTerminating = false
    var visitCount = 0
    var cityDict: City?
    var isLeaf: Bool {
        return children.count == 0
    }
    
    init(value: T? = nil, parentNode: TrieNode? = nil) {
        self.value = value
        self.parentNode = parentNode
    }
    
    func add(value: T, actualvalue1: T) {
        guard children[value] == nil else {
            return
        }
        children[value] = TrieNode(value: value, parentNode: self)
    }
}

extension Trie {
    
    // MARK: - Trie insert
    func insert(name: String, cityDetail:City) {
        guard !name.isEmpty else {
            return
        }
        var currentNode = root
        for character in name.lowercased() {
            if let childNode = currentNode.children[character] {
                currentNode = childNode
            } else {
                currentNode.add(value: character, actualvalue1: character)
                currentNode = currentNode.children[character]!
            }
        }
        guard !currentNode.isTerminating else {
            return
        }
        totalCount += 1
        currentNode.isTerminating = true
        currentNode.cityDict = cityDetail
        
    }

    // MARK: - Trie contains
    func contains(name: String) -> Bool {
        guard !name.isEmpty else {
            return false
        }
        var currentNode = root
        for character in name.lowercased() {
            guard let childNode = currentNode.children[character] else {
                return false
            }
            currentNode = childNode
        }
        return currentNode.isTerminating
    }

    // MARK: - Trie remove
    func remove(name: String) {
        guard !name.isEmpty else {
            return
        }
        guard let terminalNode = findTerminalNodeOf(name: name) else {
            return
        }
        if terminalNode.isLeaf {
            deleteNodesForWordEndingWith(terminalNode: terminalNode)
        } else {
            terminalNode.isTerminating = false
        }
        totalCount -= 1
    }

    private func deleteNodesForWordEndingWith(terminalNode: Node) {
        var lastNode = terminalNode
        var character = lastNode.value
        while lastNode.isLeaf, let parentNode = lastNode.parentNode {
            lastNode = parentNode
            lastNode.children[character!] = nil
            character = lastNode.value
            if lastNode.isTerminating {
                break
            }
        }
    }

    private func findTerminalNodeOf(name: String) -> Node? {
        if let lastNode = findLastNodeOf(name: name) {
            return lastNode.isTerminating ? lastNode : nil
        }
        return nil
    }

    // MARK: - Trie findCities
    
    func findCitiesWithPrefix(prefix: String) -> [City] {
        var words = [String]()
        var cityDict = [City]()
        let prefixLowerCased = prefix.lowercased()
        if let lastNode = findLastNodeOf(name: prefixLowerCased) {
            if lastNode.isTerminating {
                words.append(prefix)
                cityDict.append(lastNode.cityDict!)
            }
            for childNode in lastNode.children.values {
                let childWords = citiesInSubtrie(rootNode: childNode, partialWord: prefixLowerCased)
                words += childWords.0
                cityDict += childWords.1
            }
        }
        return cityDict
    }

    private func findLastNodeOf(name: String) -> Node? {
        var currentNode = root
        for character in name.lowercased() {
            guard let childNode = currentNode.children[character] else {
                return nil
            }
            currentNode = childNode
        }
        return currentNode
    }
    
    fileprivate func citiesInSubtrie(rootNode: Node, partialWord: String) -> ([String],[City]) {
        var subtrieWords = [String]()
        var cityDict = [City]()
        var previousLetters = partialWord
        if let value = rootNode.value {
            previousLetters.append(value)
        }
        if rootNode.isTerminating {
            subtrieWords.append(previousLetters)
            cityDict.append(rootNode.cityDict!)
        }
        for childNode in rootNode.children.values {
            let childValue = citiesInSubtrie(rootNode: childNode, partialWord: previousLetters)
            subtrieWords += childValue.0
            cityDict += childValue.1
        }
        return (subtrieWords,cityDict)
    }

}
