//
// Copyright (C) 2017 About Objects, Inc. All Rights Reserved.
// See LICENSE.txt for this example's licensing information.
//

import XCTest
@testable import Model

let book1 = Book(title: "Book One", year: 1999, favorite: false, rating: Rating(average: 5, count: 32))
let book2 = Book(title: "Book Two", year: 2001, favorite: true, rating: Rating(average: 4, count: 27))

let author = Author(firstName: "Fred", lastName: "Smith", books: [book1, book2])
