//
// Copyright (C) 2017 About Objects, Inc. All Rights Reserved.
// See LICENSE.txt for this example's licensing information.
//

import Foundation

struct Book: Codable {
    var title: String
    var year: Int?
    var favorite: Bool = false
    var rating: Rating
}
