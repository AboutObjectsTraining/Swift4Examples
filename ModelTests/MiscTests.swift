// Copyright (C) 2017 About Objects, Inc. All Rights Reserved.
// See LICENSE.txt for this project's licensing information.

import XCTest

fileprivate struct Grocery {
    let name: String
    let price: Double
    let quantity: Int
}

fileprivate struct Friend {
    var firstName: String
    var lastName: String
    var age: Int
}

class MiscTests: XCTestCase
{
    override func setUp() { super.setUp(); print() }
    override func tearDown() { print(); super.tearDown() }
    
    func testGroceries() {
        let groceries = [Grocery(name: "Apples", price: 0.65, quantity: 12),
                         Grocery(name: "Milk", price: 1.25, quantity: 2),
                         Grocery(name: "Crackers", price: 2.35, quantity: 3)]
        
        let costs = groceries.map {
            (name: $0.name, cost: $0.price * Double($0.quantity))
        }
        costs.forEach { print($0) }
        print(costs)
        // [(Apples, 7.8), (Milk, 2.5), (Crackers, 7.05)]
        // [(name: "Apples", cost: 7.8), (name: "Milk", cost: 2.5), (name: "Crackers", cost: 7.05)]
        
        let total = groceries.reduce(0.0) { sum, item in
            sum + (item.price * Double(item.quantity))
        }
        print(total)
        // 17.35
        
        let string = costs.reduce("") { text, item in
            "\(text)name: \(item.name), cost: \(item.cost)\n"
        }
        print(string)
        // name: Apples, cost: 7.8
        // name: Milk, cost: 2.5
        // name: Crackers, cost: 7.05
        
        let header = "Groceries\n--------------\n"
        let text = costs.reduce(header) { result, item in
            String(format: "%@%@%6.2f\n", result,
                   item.name.padding(toLength: 8, withPad: " ", startingAt: 0),
                   item.cost)
        }
        print(text)
        // Groceries
        // --------------
        // Apples    7.80
        // Milk      2.50
        // Crackers  7.05
    }
    
    func testFriends() {
        // public convenience init?(_ description: String)

        let friends = [Friend(firstName: "Fred", lastName: "Smith", age: 27),
                       Friend(firstName: "Janet", lastName: "Wade", age: 31),
                       Friend(firstName: "Gale", lastName: "Dee", age: 42),
                       Friend(firstName: "Jan", lastName: "Grey", age: 29)]
        
        let under30 = friends
            .filter { $0.age < 30 }
            .map { "\($0.firstName) \($0.lastName), \($0.age)" }
        print(under30)
        // ["Fred Smith, 27", "Jan Grey, 29"]
    }
}
