//
// Copyright (C) 2017 About Objects, Inc. All Rights Reserved.
// See LICENSE.txt for this example's licensing information.
//

import Foundation

enum Garment {
    case tie
    case shirt(size: String)
    case pants(waist: Int, inseam: Int)
}

extension Garment: CustomStringConvertible {
    var description: String {
        switch self {
        case .tie:             return "tie"
        case let .shirt(s):    return "shirt: \(s)"
        case let .pants(w, i): return "pants: \(w)X\(i)"
        }
    }
}

extension Garment: Equatable {
    static func ==(lhs: Garment, rhs: Garment) -> Bool {
        switch (lhs, rhs) {
        case (.tie, .tie): return true
        case let (.shirt(size1), .shirt(size2)):
            return size1 == size2
        case let (.pants(waist1, inseam1), .pants(waist2, inseam2)):
            return waist1 == waist2 && inseam1 == inseam2
        default: return false
        }
    }
}

func show(item: Garment)
{
    switch item {
    case .tie: print("tie")
    case .shirt(let s): print("shirt, \(s)")
    case .pants(let w, let i): print("pants, \(w)X\(i)")
    }
    
    switch item {
    case .tie: print("tie")
    case let .shirt(s): print("shirt, \(s)")
    case let .pants(w, i): print("pants, \(w)X\(i)")
    }
}

