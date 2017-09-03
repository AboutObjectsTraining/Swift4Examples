//
// Copyright (C) 2017 About Objects, Inc. All Rights Reserved.
// See LICENSE.txt for this example's licensing information.
//
import XCTest

class EnumsTests: XCTestCase
{
    let items = [
        Garment.tie,
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
    
    func testFilterShirtsByAssociatedValue1() {
        let shirts = items.filter {
            if case let .shirt(size) = $0, size == "XL" {
                return true
            }
            return false
        }
        print(shirts)
    }
    
    func testFilterShirtsByAssociatedValue2() {
        let shirts = items.filter {
            switch $0 {
            case let .shirt(size): return size == "XL"
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
