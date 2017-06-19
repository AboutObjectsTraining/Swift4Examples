//
// Copyright (C) 2017 About Objects, Inc. All Rights Reserved.
// See LICENSE.txt for this example's licensing information.
//

import Foundation

struct Person: Encodable {
    static let userInfoKey: CodingUserInfoKey! = CodingUserInfoKey(rawValue: "com.aboutobjects.person.codingUserInfoKey")
    
    struct Context {
        let encodeFriends: Bool
        let encodeRating: Bool
    }
    
    enum Keys: String, CodingKey {
        case name
        case dateOfBirth
        case friends
        case rating
    }
    
    var name: String
    var dateOfBirth: Date
    var friends: [Person]
    var rating: Rating
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Keys.self)
        try container.encode(name, forKey: .name)
        try container.encode(dateOfBirth, forKey: .dateOfBirth)
        
        let info = encoder.userInfo
        guard let context = info[Person.userInfoKey] as? Person.Context else {
            return
        }
        
        if context.encodeFriends {
            try container.encode(friends, forKey: .friends)
        }
        
        if context.encodeRating {
            try container.encode(rating, forKey: .rating)
        }
    }
}

