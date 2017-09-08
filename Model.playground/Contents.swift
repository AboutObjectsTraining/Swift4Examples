import Foundation
import Model

let item1 = Garment.tie

// Overloaded implementation of Equatable
item1 == Garment.tie

let pants1 = Garment.pants(waist: 32, inseam: 34)
let pants2 = Garment.pants(waist: 32, inseam: 34)
let pants3 = Garment.pants(waist: 33, inseam: 35)

pants1 == pants2
pants1 == pants3

let foo = Apparel.tie

let jacket1 = Apparel.jacket(size: .small)
let jacket2 = Apparel.jacket(size: .small)

// Compile error: no overload of == for type Apparel
//
// jacket1 == jacket2

if case let Apparel.jacket(size1) = jacket1,
    case let Apparel.jacket(size2) = jacket2,
    size1 == size2 {
    print("Same size jacket")
}

let size = "Large"
var larges = 0
var extraLarges = 0

switch size {
case "Large": larges += 1
case "Extra Large": extraLarges += 1
default: print("No match")
}

if case "Large" = size { larges += 1 }

