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
"rating": { "average": 4.5, "count": 23 }
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
    override func setUp() { super.setUp(); print() }
    override func tearDown() { print(); super.tearDown() }
    
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
    
    
    var authorUrl: URL {
        var url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        url.appendPathComponent("Authors")
        url.appendPathExtension("json")
        return url
    }
    
    func testStoreAuthorAndNestedBook() throws {
        let authorData = try encoder.encode(author)
        print(String(data: authorData, encoding: .utf8)!)
        
        do {
            try authorData.write(to: authorUrl)
        }
        catch let e {
            print(e)
            XCTFail()
        }
        
        let fetchedData = try Data(contentsOf: authorUrl, options: [])
        let fetchedAuthor = try decoder.decode(Author.self, from: fetchedData)
        print(fetchedAuthor)
    }
}

// MARK: - Custom Coding

private let iTunesEbookJson = """
{
"fileSizeBytes":5990135,
"currency":"USD",
"artistId":2122513,
"artistName":"Ernest Hemingway",
"genres":["Classics", "Books", "Fiction & Literature", "Literary"],
"kind":"ebook",
"price":9.99,
"description":"One of the enduring works of American fiction.",
"trackName":"The Old Man and the Sea",
"trackId":381645838,
"formattedPrice":"$9.99",
"releaseDate":"2002-07-25T07:00:00Z",
"averageUserRating":4.5,
"userRatingCount":660
}
"""

extension CoderTests {
    func testCustomDecodeFromJsonText() throws {
        let data = iTunesEbookJson.data(using: .utf8) ?? Data()
        print(String(data: data, encoding: .utf8) ?? "null")
        
        let newEbook = try decoder.decode(Ebook.self, from: data)
        print(newEbook)
    }
    
    func testCustomEncodeEbook() throws {
        let data = try encoder.encode(ebook)
        print(String(data: data, encoding: .utf8) ?? "null")
    }
    
    func testDecodeEbookFromJsonFile() throws {
        let bundle = Bundle(for: type(of: self))
        guard let url = bundle.url(forResource: "ebook", withExtension: "json") else {
            XCTFail("Unable to find JSON file in directory \(bundle.bundlePath)"); return
        }
        
        let data = try Data(contentsOf: url, options:[])
        let newEbook = try decoder.decode(Ebook.self, from: data)
        print(newEbook)
    }
}

