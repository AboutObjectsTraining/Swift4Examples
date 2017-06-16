//
// Copyright (C) 2017 About Objects, Inc. All Rights Reserved.
// See LICENSE.txt for this example's licensing information.
//

import XCTest
@testable import Model

class KVCTests: XCTestCase {
    override func setUp() { super.setUp(); print() }
    override func tearDown() { print(); super.tearDown() }
    
    func testKVCValues() throws {
        var book = book1
        book = book1 // FIXME: supressed warning
        
        let title = book[keyPath: \Book.title]
        print(title)
        
        book[keyPath: \Book.title] = "New Title"
        print(book.title)
        
        book[keyPath: \Book.year] = 2000
        print(book)
    }
    
    func testKVCNestedValues() throws {
        let rating = book1[keyPath: \Book.rating.average]
        let count = book1[keyPath: \Book.rating.count]
        print("Average rating: \(rating), number of ratings: \(count)")
        
        var book = book1
        book = book1 // FIXME: suppressed warning
        
        book[keyPath: \Book.rating.count] = 33
        print("Number of ratings: \(book[keyPath: \Book.rating.count])")
        book[keyPath: \Book.rating.count] += 1
        print("Number of ratings: \(book[keyPath: \Book.rating.count])")
    }
}
