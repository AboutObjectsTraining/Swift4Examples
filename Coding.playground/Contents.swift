//: Playground - noun: a place where people can play

import Foundation

// Instantiate an encoder
let encoder = JSONEncoder()

//Instantiate a decoder
let decoder = JSONDecoder()

// Configure a property for nicely formatted output.
encoder.outputFormatting = .prettyPrinted

//let d = ["firstName": "Fred",
//         "lastName": "Smith"]
//
//do {
//    let data = try encoder.encode(d)
//    print(data)
//    let jsonObj = try decoder.decode(Dictionary<String, String>.self, from: data)
//    print(jsonObj)
//
//} catch {
//    print(error)
//}

//struct Person: Codable {
//    var name: String
//    var age: Int
//}


struct Dog: Codable {
    var name: String
    var breed: Breed
    
    // Note that the Breed enum adopts Codable, which is
    // automatically supported for enums that have raw values.
    enum Breed: String, Codable {
        case collie = "Collie"
        case beagle = "Beagle"
        case greatDane = "Great Dane"
    }
}

struct Person: Codable {
    var name: String
    var age: Int
    var dog: Dog
}

//class Group: Codable, CustomStringConvertible {
//    var title: String
//    var people: [Person]
//
//    init(title: String, people: [Person]) {
//        self.title = title
//        self.people = people
//    }
//
//    var description: String {
//        return "\(Group.self)(title: \"\(title)\", people: \n\(people))"
//    }
//}

class Group: Codable, CustomStringConvertible {
    var title: String
    var people: [Person]
//    var imageUrl: URL
    
    init(title: String, people: [Person]) {
        self.title = title
        self.people = people
    }
    
//    init(title: String, imageUrl: URL, people: [Person]) {
//        self.title = title
//        self.people = people
//        self.imageUrl = imageUrl
//    }
    
    var description: String {
        return "\(Group.self)(title: \"\(title)\", people: \n\(people))"
    }
    
//    var description: String {
//        return "\(Group.self)(title: \"\(title)\", url: \"\(imageUrl)\", people: \n\(people))"
//    }
}


// Given an instance of Person with a nested Dog...
let fred = Person(name: "Fred", age: 30, dog: Dog(name: "Spot", breed: .beagle))

// Pass the object to the encoder's encode method
let data = try! encoder.encode(fred)
print(String(data: data, encoding: .utf8)!)

// Pass JSON data to the decoder's decode method.
let fredsClone = try! decoder.decode(Person.self, from: data)

//print(fredsClone)

// Initializing a group
let jim = Person(name: "Jim", age: 30, dog: Dog(name: "Rover", breed: .beagle))
let sue = Person(name: "Sue", age: 27, dog: Dog(name: "Lassie", breed: .collie))
let group = Group(title: "Dog Lovers", people: [fred, sue])

// Encoding the group
let groupData = try! encoder.encode(group)
print(String(data: groupData, encoding: .utf8)!)

// Decoding the group
let clonedGroup = try! decoder.decode(Group.self, from: groupData)
print(clonedGroup)


//let url = URL(string: "https://www.aboutobjects.com/images/Logo-WhiteText.png")!
//let group2 = Group(title: "We ❤️ Dogs", imageUrl: url, people: [jim, sue])
//
//print(group2)


struct BlogPost: Codable {
    let title: String
    let date: Date
    let baseUrl: URL = URL(string: "https://media.aboutobjects.com/blog")!
}

let blog = BlogPost(title: "Swift 4 Coding", date: Date())

encoder.dateEncodingStrategy = .iso8601

let blogData = try! encoder.encode(blog)
print(String(data: blogData, encoding: .utf8)!)

decoder.dateDecodingStrategy = .iso8601
let clonedBlog = try! decoder.decode(BlogPost.self, from: blogData)

print(clonedBlog)

struct Book: Codable {
    var title: String
    var author: String
    var year: Int
    var pageCount: Int
    
    enum CodingKeys: String, CodingKey {
        case title
        case author
        case year = "publication_year"
        case pageCount = "number_of_pages"
    }
}

// Uses Swift 4 multiline string literal syntax:
let bookJsonText =
"""
{
"title": "War of the Worlds",
"author": "H. G. Wells",
"publication_year": 2012,
"number_of_pages": 240
}
"""

let bookData = bookJsonText.data(using: .utf8)!
let book = try! decoder.decode(Book.self, from: bookData)

print(book)


let eBookJsonText = """
{
"fileSize":5990135,
"title":"The Old Man and the Sea",
"author":"Ernest Hemingway",
"releaseDate":"2002-07-25T07:00:00Z",
"averageUserRating":4.5,
"userRatingCount":660
}
"""

struct Rating {
    var average: Double
    var count: Int
}

struct EBook {
    var title: String
    var author: String
    var releaseDate: Date
    var rating: Rating
    
    enum CodingKeys: String, CodingKey {
        case title
        case author
        case releaseDate
        case averageUserRating
        case userRatingCount
    }
}

extension EBook: Decodable {
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        title = try values.decode(String.self, forKey: .title)
        author = try values.decode(String.self, forKey: .author)
        releaseDate = try values.decode(Date.self, forKey: .releaseDate)
        let average = try values.decode(Double.self, forKey: CodingKeys.averageUserRating)
        let count = try values.decode(Int.self, forKey: CodingKeys.userRatingCount)
        rating = Rating(average: average, count: count)
    }
}

extension EBook: Encodable {
    func encode(to encoder: Encoder) throws {
        var values = encoder.container(keyedBy: CodingKeys.self)
        try values.encode(title, forKey: .title)
        try values.encode(author, forKey: .author)
        try values.encode(releaseDate, forKey: .releaseDate)
        try values.encode(rating.average, forKey: CodingKeys.averageUserRating)
        try values.encode(rating.count, forKey: CodingKeys.userRatingCount)
    }
}

let numbers = 1...5
let fact = numbers.reduce(1, *)


