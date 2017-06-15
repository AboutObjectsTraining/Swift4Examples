//
// Copyright (C) 2017 About Objects, Inc. All Rights Reserved.
// See LICENSE.txt for this example's licensing information.
//

import XCTest
@testable import Model

private let decoder: JSONDecoder = JSONDecoder()

private let encoder: JSONEncoder = {
    let encoder = JSONEncoder()
    encoder.outputFormatting = .prettyPrinted
    return encoder
}()

private let book1Json = """
{
"title": "Title One",
"year": 2017,
"favorite": true,
"rating": { "average": 4, "count": 23 }
}
"""
private let book2Json = """
{
"title": "Title Two",
"year": 2016,
"favorite": false,
"rating": { "average": 5, "count": 12 }
}
"""

private let authorJson = """
{
"firstName": "FNameOne",
"lastName": "LNameOne"
}
"""

private let authorAndBooksJson = """
{
"firstName": "FNameTwo",
"lastName": "LNameTwo",
"books": [\(book1Json), \(book2Json)]
}
"""

class CoderTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    override func tearDown() {
        super.tearDown()
    }
    
    func testEncodeAndDecodeBook() throws {
        let data = try encoder.encode(book1)
        print(String(data: data, encoding: .utf8) ?? "null")
        
        let newBook = try decoder.decode(Book.self, from: data)
        print(newBook)
    }
    
    func testEncodeAndDecodeAuthor() throws {
        let data = try encoder.encode(author)
        print(String(data: data, encoding: .utf8) ?? "null")
        
        let newAuthor = try decoder.decode(Author.self, from: data)
        print(newAuthor)
    }
    
    func testDecodeBookFromJsonText() throws {
        let data = book1Json.data(using: .utf8) ?? Data()
        print(String(data: data, encoding: .utf8) ?? "null")
        
        let newBook = try decoder.decode(Book.self, from: data)
        print(newBook)
    }
    
    func testDecodeAuthorFromJsonText() throws {
        let data = authorJson.data(using: .utf8) ?? Data()
        print(String(data: data, encoding: .utf8) ?? "null")
        
        let newAuthor = try decoder.decode(Author.self, from: data)
        print(newAuthor)
    }
    
    func testDecodeAuthorAndNestedBookFromJsonText() throws {
        let data = authorAndBooksJson.data(using: .utf8) ?? Data()
        print(String(data: data, encoding: .utf8) ?? "null")
        
        let newAuthor = try decoder.decode(Author.self, from: data)
        print(newAuthor)
    }
}
