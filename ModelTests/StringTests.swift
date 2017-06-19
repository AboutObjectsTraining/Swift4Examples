//
// Copyright (C) 2017 About Objects, Inc. All Rights Reserved.
// See LICENSE.txt for this example's licensing information.
//

import XCTest

class StringTests: XCTestCase {
    override func setUp() { super.setUp(); print() }
    override func tearDown() { print(); super.tearDown() }
    
    func testStringBasics() {
        let s = "Hello World!"
        print(s.count)
        print(s.contains("World"))
        
        print(s.substring(to: s.index(of: " ")!))
        print(s.substring(with: s.index(of: "W")!..<s.index(of: "!")!))
        
        print(s.suffix(from: s.index(of: "W")!))
    }
    
    func testPlist() {
        print(personText.propertyList())
    }
}
