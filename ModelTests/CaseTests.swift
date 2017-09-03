//
// Copyright (C) 2017 About Objects, Inc. All Rights Reserved.
// See LICENSE.txt for this example's licensing information.
//
import XCTest
@testable import Model

private let number = 42

enum Apparel {
    enum Size: String, CustomStringConvertible {
        case small = "SM", medium = "M", large = "L", extraLarge = "XL"
        var description: String {
            return rawValue
        }
    }
    case tie
    case shirt(size: Size)
    case jacket(size: Size)
}

class CaseTests: XCTestCase {
    override func setUp() { super.setUp(); print() }
    override func tearDown() { print(); super.tearDown() }
 
    func testNestedEnum() {
        let shirt = Apparel.shirt(size: .small)
        print(shirt)
        if case let .shirt(size) = shirt, size == .small { print(size) }
    }
    
    func testCaseComparison() {
        switch(number) {
        case ..<3: print("Less than 3")
        case 3: print("3")
        case 4...: print("greater than 3")
        default: print("")
        }
    }
    
    func testAssociatedValues() {
        let item = Apparel.shirt(size: .extraLarge)
        if case let .shirt(size) = item { print(size) }
        
        let garment = Garment.shirt(size: "L")
        if case let .shirt(size) = garment { print(size) }
        
        let name: String? = "Fred"
        if case let .some(unwrappedName) = name { print(unwrappedName) }
        // The compiler infers the keyword `case` along with the pattern match for `Optional.some`,
        // which allows you to rewrite the previous line as follows:
        if let unwrappedName = name { print(unwrappedName) }
    }
}
