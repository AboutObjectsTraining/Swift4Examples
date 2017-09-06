// Copyright (C) 2017 About Objects, Inc. All Rights Reserved.
// See LICENSE.txt for this project's licensing information.

import Foundation

public enum Apparel {
    public enum Size: String, CustomStringConvertible {
        case small = "SM"
        case medium = "M"
        case large = "L"
        case extraLarge = "XL"
        public var description: String { return rawValue }
    }
    case tie
    case shirt(size: Size)
    case jacket(size: Size)
}

