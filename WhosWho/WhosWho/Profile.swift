//
//  Profile.swift
//  WhosWho
//
//  Created by Rachel Yee on 1/11/22.
//

import Foundation

struct Profile: Identifiable, Codable, Equatable {
    var id: UUID
    var name: String
    var location: String
    var description: String
    var photo: Data?
    
    static let example = Profile(id: UUID(), name: "John Appleseed", location: "Comic Con 2021", description: "Guy in Spiderman costume")
    
    static func == (lhs: Profile, rhs: Profile) -> Bool {
        lhs.id == rhs.id
    }
}


