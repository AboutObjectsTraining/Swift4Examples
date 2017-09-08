// Copyright (C) 2017 About Objects, Inc. All Rights Reserved.
// See LICENSE.txt for this project's licensing information.

import Foundation

enum Size1: String {
    case small = "S"
    case medium = "M"
    case large = "L"
    case extraLarge = "XL"
}

let mySize = Size1.extraLarge
print("Size \(mySize.rawValue)")

enum Garment1 {
    case tie
    case shirt(size: String)
    //        ^^^^^^^^^^^^^^
    //        associated value
}

enum Garment {
    case tie
    case shirt(size: String)
    case pants(waist: Int, inseam: Int)
}

let someGarment = Garment.pants(waist: 32, inseam: 34)

switch someGarment {
    case .tie: print("tie")
    case .shirt: print("shirt")
    case .pants: print("pants")
}

let items = [
    Garment.tie,
    Garment.shirt(size: "S"),
    Garment.shirt(size: "M"),
    Garment.shirt(size: "L"),
    Garment.pants(waist: 29, inseam: 32),
    Garment.pants(waist: 35, inseam: 34)
]

for item in items {
    switch item {
    case .tie: print("tie")
    case .shirt("M"): print("\(item) may fit")
    case .shirt("L"): print("\(item) may fit")
    case .shirt: print("\(item) won't fit")
    case .pants(34, 34): print("\(item) may fit")
    case .pants(35, 34): print("\(item) may fit")
    case .pants: print("\(item) won't fit")
    }
}

switch someGarment {
    case .tie: print("tie")
    case .shirt(let s): print("shirt, size: \(s)")
    case .pants(let w, let i): print("pants, size \(w) X \(i)")
}

switch someGarment {
    case .tie: print("tie")
    case let .shirt(s): print("shirt, size: \(s)")
    case let .pants(w, i): print("pants, waist: \(w), inseam: \(i)")
}

switch someGarment {
    case let .pants(w, i) where w == 32: print("inseam: \(i)")
    default: print("No match")
}

//print(someGarment == Garment2.pants(waist: 32, inseam: 34))

enum Size: String, CustomStringConvertible {
    case small = "SM"
    case medium = "M"
    case large = "L"
    case extraLarge = "XL"
    
    var description: String {
        return rawValue
    }
}

//enum Garment {
//    case tie
//    case shirt(size: Size)
//    case pants(waist: Int, inseam: Int)
//}

enum GarmentType {
    enum Size: String, CustomStringConvertible {
        case small = "S", medium = "M", large = "L", extraLarge = "XL"
        var description: String {
            return rawValue
        }
    }
    case tie
    case shirt(size: Size)
    case pants(waist: Int, inseam: Int)
}



func showShirts(garments: [Garment]) {
    for garment in garments {
        if case Garment.shirt = garment {
            print(garment)
        }
    }
}

let garments = [Garment.tie, Garment.shirt(size: "L"), Garment.shirt(size: "XL")]
showShirts(garments: garments)



struct Garment3: CustomStringConvertible {
    
    enum Size: String, CustomStringConvertible {
        case small = "SM", medium = "M", large = "L", extraLarge = "XL"
        var description: String {
            return rawValue
        }
    }
    
    enum `Type` {
        case tie
        case shirt(size: Size)
        case pants(waist: Int, inseam: Int)
    }
    
    var type: Type
    var price: Double
    var details: String
    
    var description: String {
        return "\(details) \(type), $\(price)"
    }
}

let item = Garment3(type: .shirt(size: .small),
                   price: 49.95,
                   details: "Long-sleeved, button-down oxford")
print(item)


