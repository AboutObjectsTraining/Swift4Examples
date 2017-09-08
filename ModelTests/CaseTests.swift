//
// Copyright (C) 2017 About Objects, Inc. All Rights Reserved.
// See LICENSE.txt for this example's licensing information.
//
import XCTest
@testable import Model

private let number = 42

class CaseTests: XCTestCase {
    override func setUp() { super.setUp(); print() }
    override func tearDown() { print(); super.tearDown() }

    func testIfCase() {
        let tie = Apparel.tie
        if case Apparel.tie = tie {
            print("Yup, a tie")
        }
    }
    
    func testNestedEnum() {
        let shirt = Apparel.shirt(size: .small)
        print(shirt)
        
        if case let .shirt(size) = shirt, size == .small { print(size) }
    }
    
    func testCaseComparison() {
        
        let numbers = [-1, 3, 9, 42]
        for number in numbers {
            switch(number) {
            case ..<3: print("less than 3")
            case 3: print("3")
            case 4...9: print("4 through 9")
            default: print("greater than 10")
            }
        }
        
        if case ..<3 = 2 {
            print("Number less than 3")
        }
    }
//    Less than 3
//    3
//    4 through 9
//    Greater than 10

    
    func testOtherStuff() {
        let greeting = "Hello"
        if case "Foo" = greeting {
            print("Foo")
        }
        
        let foo = "Foo"
        if "Foo" ~= foo {
            print("Foo indeed")
        }
        
        let color = "Red"
        
        if case "Red" = color {
            print("Matched color")
        }
    }
    
    
    struct Song {
        var title: String
        var artist: String
    }
    
    func testPatternMatchWithString() {
        let aria = Song(title: "Donna non vidi mai", artist: "Luciano Pavarotti")
        
        switch(aria.artist) {
        case "Luciano Pavarotti": print(aria)
        default: print("No match")
        }
    }
    
//
//    func testTuplePatternMatch() {
//        let dogs = [Dog(name: "Rover", breed: "Lab", age: 2),
//                    Dog(name: "Spot", breed: "Beagle", age: 2),
//                    Dog(name: "Pugsly", breed: "Pug", age: 9),
//                    Dog(name: "Biff", breed: "Pug", age: 5)]
//
////        for dog in dogs {
////            switch (dog.breed, dog.age) {
////            case ("Lab", ...3):  print("\(dog.name) is a young Lab")
////            case ("Pug", 8...): print("\(dog.name) is an older Pug")
////            default: print("unmatched \(dog.age) year old \(dog.breed)")
////            }
////        }
//
//        for dog in dogs {
//            switch (dog.breed, dog.age) {
//            case ("Lab", ...3): print("matched a young Lab named \(dog.name)")
//            case ("Pug", 8...): print("matched an older Pug named \(dog.name)")
//            default: print("no match for \(dog.age) year old \(dog.breed)")
//            }
//        }
//    }
// matched a young Lab named Rover
// no match for 2 year old Beagle
// matched an older Pug named Pugsly
// no match for 5 year old Pug

    
    func testTuplePatternMatch2() {
        let dogs = [(name: "Rover", breed: "Lab", age: 2),
                    (name: "Spot", breed: "Beagle", age: 2),
                    (name: "Pugsly", breed: "Pug", age: 9),
                    (name: "Biff", breed: "Pug", age: 5)]
        
        for dog in dogs {
            switch (dog) {
            case (_, "Lab", ...3): print("matched a young Lab named \(dog.name)")
            case (_, "Pug", 8...): print("matched an older Pug named \(dog.name)")
            default: print("no match for \(dog.age) year old \(dog.breed)")
            }
        }
    }

    struct Dog {
        var name: String
    }

    func testTypeCastingPatternMatch() {
        let items: [Any] = [Dog(name: "Rover"), 42, 99, "Hello", (0, 0)]
        
        for item in items {
            switch(item) {
            case is Dog: print("Nice doggie")
            case 42 as Int: print("integer 42")
            case let i as Int: print("integer \(i)")
            case let s as String: print("string with value: \(s)")
            default: print("something else")
            }
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
