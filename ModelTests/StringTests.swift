//
// Copyright (C) 2017 About Objects, Inc. All Rights Reserved.
// See LICENSE.txt for this example's licensing information.
//

import XCTest

extension String {
    public func leadingIndex(of character: Character) -> String.Index {
        return index(of: character) ?? startIndex
    }
    public func trailingIndex(of character: Character) -> String.Index {
        return index(of: character) ?? endIndex
    }
    public func prefix(upTo character: Character) -> String.SubSequence {
        return self[..<leadingIndex(of: character)]
    }
    public func suffix(from character: Character) -> String.SubSequence {
        return self[trailingIndex(of: character)..<endIndex]
    }
}

class StringTests: XCTestCase {
    override func setUp() { super.setUp(); print() }
    override func tearDown() { print(); super.tearDown() }
    
    
    func testExtendedGraphemeCluster() {
        let usFlag: Character = "\u{1F1FA}\u{1F1F8}"
        print(usFlag)
    }
    
    func testStringBasics() {
        let s = "Hello World!"
        print(s.count)
        print(s.contains("World"))
        
        let indexOfSpace = s.index(of: " ") ?? s.endIndex
        print(s[..<indexOfSpace])
        
        let indexOfW = s.index(of: "W") ?? s.startIndex
        let indexOfExclamation = s.index(of: "!") ?? s.endIndex
        print(s[indexOfW...indexOfExclamation])
        
        print(s[..<s.leadingIndex(of: " ")])
        print(s[s.leadingIndex(of: "W")...s.trailingIndex(of: "!")])
        
        // Swift 3 implementation
        //
        // print(s.substring(to: s.index(of: " ")!))
        // print(s.substring(with: s.index(of: "W")!..<s.index(of: "!")!))
        
        print(s.prefix(upTo: indexOfSpace))
        print(s.suffix(from: indexOfW))
        
        print(s.prefix(upTo: " "))
        print(s.suffix(from: "W"))
    }
    
    func testPlist() {
        print(personInfoString.propertyList())
        
        guard let personInfo = personInfoString.propertyList() as? [String: Any] else { fatalError() }
        let name = personInfo["name"] ?? ""
        print(name)
        
        guard let phones = personInfo["phones"] as? [String] else { fatalError() }
        phones.forEach { print($0) }
    }
}
