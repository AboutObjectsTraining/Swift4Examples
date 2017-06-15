//
//  Ebook.swift
//  Model
//
//  Created by Jonathan Lehr on 6/15/17.
//  Copyright © 2017 Jonathan Lehr. All rights reserved.
//

import Foundation

struct Ebook {
    var ebookId: Int?
    var title: String?
    var rating: Rating?
    
    enum Keys: String, CodingKey {
        case ebookId = "trackId"
        case title = "trackName"
        case averageUserRating
        case userRatingCount
    }
}

extension Ebook: Decodable {
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: Keys.self)
        ebookId = try values.decode(Int.self, forKey: .ebookId)
        title = try values.decode(String.self, forKey: .title)
        
        let average = try values.decode(Double.self, forKey: Keys.averageUserRating)
        let count = try values.decode(Int.self, forKey: Keys.userRatingCount)
        rating = Rating(average: average, count: count)
    }
}

extension Ebook: Encodable {
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Keys.self)
        try container.encode(ebookId, forKey: .ebookId)
        try container.encode(title, forKey: .title)
        try container.encode(rating?.average, forKey: Keys.averageUserRating)
        try container.encode(rating?.count, forKey: Keys.userRatingCount)
    }
}
