//
// Copyright (C) 2017 About Objects, Inc. All Rights Reserved.
// See LICENSE.txt for this example's licensing information.
//
import XCTest
@testable import Model

class EnumsTests: XCTestCase
{
    let items = [
        Garment.tie,
        Garment.shirt(size: "M"),
        Garment.shirt(size: "L"),
        Garment.shirt(size: "XL"),
        Garment.pants(waist: 32, inseam: 34)
    ]
    
    func testAssociatedValues() {
        for item in items {
            print(item)
        }
        print(items)
    }
    
    func testFilterTies() {
        let ties = items.filter { $0 == .tie }
        print(ties)
    }
    
    func testFilterShirts() {
        let shirts = items.filter {
            if case .shirt = $0 { return true }
            return false
        }
        print(shirts)
    }
    
    func testMatchShirts1() {
        for item in items {
            if case .shirt = item {
                print(item)
            }
        }
    }
// shirt: M
// shirt: L
// shirt: XL
    
    func testMatchShirts1_1() {
        for case let .shirt(size) in items {
            print("shirt, size \(size)")
        }
    }
    
    func testMatchShirts1_2() {
        for case .shirt("XL") in items {
            print("shirt, size XL")
        }
    }
    
    func testMatchXLShirts1() {
        for item in items {
            if case .shirt("XL") = item {
                print(item)
            }
        }
    }
    // shirt: XL
    
    func testFilterShirtsByAssociatedValue1() {
        for item in items {
            if case let .shirt(size) = item, size.contains("L") {
                print(item)
            }
        }
    }
    // shirt: L
    // shirt: XL

    func testFilterShirtsByAssociatedValue1_1() {
        for case let .shirt(size) in items where size.contains("L") {
            print("shirt, size \(size)")
        }
    }
    
    func testFilterShirtsByAssociatedValue1_3() {
        let items:[Garment] = [
            .tie,
            .shirt(size: "L"),
            .pants(waist: 35, inseam: 31),
            .pants(waist: 35, inseam: 34),
            .pants(waist: 35, inseam: 35),
        ]
        
        for case let .pants(w, i) in items where w == 35 && 34...36 ~= i {
            print("pants, \(w) X \(i)")
        }
        
        
        let r = 1...4
        print(r.contains(2))
        print(1...4 ~= 2)
        print(r ~= 5)
    }
    

    func testFilterShirtsByAssociatedValue1_2() {
        let shirts = items.filter {
            if case .shirt("XL") = $0 {
                return true
            }
            return false
        }
        print(shirts)
    }
    
    func testFilterShirtsByAssociatedValue2() {
        let shirts = items.filter {
            switch $0 {
            case let .shirt(size): return size.contains("L")
            default: return false
            }
        }
        print(shirts)
    }
    
    func testFilterShirtsByAssociatedValue2_1() {
        let shirts = items.filter {
            switch $0 {
            case .shirt("XL"): return true
            default: return false
            }
        }
        print(shirts)
    }
    
    func testFilterPantsByAssociatedValues1() {
        let pants = items.filter {
            if case let .pants(waist, inseam) = $0, waist == 32, inseam == 34 {
                return true
            }
            return false
        }
        print(pants)
    }

    func testFilterPantsByAssociatedValues2() {
        let pants = items.filter {
            switch $0 {
            case let .pants(waist, inseam): return waist == 32 && inseam == 34
            default: return false
            }
        }
        print(pants)
    }
}
