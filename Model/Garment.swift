//
// Copyright (C) 2017 About Objects, Inc. All Rights Reserved.
// See LICENSE.txt for this example's licensing information.
//

import Foundation

public enum Garment {
    case tie
    case shirt(size: String)
    case pants(waist: Int, inseam: Int)
}

extension Garment: CustomStringConvertible {
    public var description: String {
        switch self {
        case .tie:             return "tie"
        case let .shirt(s):    return "shirt: \(s)"
        case let .pants(w, i): return "pants: \(w) X \(i)"
        }
    }
}

extension Garment: Equatable {
    public static func ==(lhs: Garment, rhs: Garment) -> Bool {
        switch (lhs, rhs) {
        case (.tie, .tie): return true
        case let (.shirt(s1), .shirt(s2)):
            return s1 == s2
        case let (.pants(w1, i1), .pants(w2, i2)):
            return w1 == w2 && i1 == i2
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

