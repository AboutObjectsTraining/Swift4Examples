//
// Copyright (C) 2017 About Objects, Inc. All Rights Reserved.
// See LICENSE.txt for this example's licensing information.
//

import XCTest
@testable import Model

class DictionaryTests: XCTestCase {
    override func setUp() { super.setUp(); print() }
    override func tearDown() { print(); super.tearDown() }
    
    let bookDict: [String: Any] = ["title": "Book Title",
                                   "year": 1999]
    
    func testContainsKey() throws {
        let key = bookDict.keys.first!
        XCTAssertTrue(bookDict.keys.contains(key))
    }
    
    func testObtainIndexOfKey() throws {
        let index = bookDict.index(forKey: "year")!
        let value = bookDict.values[index] as? String
        XCTAssertEqual(value, bookDict["year"] as? String)
    }
    
    func testSubscriptWithIndex() throws {
        let index = bookDict.index(forKey: "year")!
        let entry = bookDict[index]
        print(entry)
        let key = bookDict.keys[index]
        print(key)
        let value = bookDict.values[index]
        print(value)
    }
    
    func testMutateNestedArray() {
        // NOTE: This works without casts for strongly typed dictionaries
        // (e.g., the following dictionary's type is `[String: [String]]`).
        //
        var dict = [
            "cats": ["leo", "tiger"],
            "dogs": ["spot", "rover"]
        ]
        
        dict["cats"]?.append("kitty")
        
        print(dict)
        XCTAssertEqual(dict["cats"]!.count, 3)
        
        let dogsKey = "dogs"
        let dogName = "fido"
        
        // Append to existing value if present; otherwise, add new element
        if let index = dict.index(forKey: "dogs") {
            dict.values[index].append(dogName)
        } else {
            dict[dogsKey] = [dogName]
        }
        
        print(dict)
        XCTAssertEqual(dict["dogs"]!.count, 3)
    }
}
