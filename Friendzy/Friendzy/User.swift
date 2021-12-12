//
//  User.swift
//  Friendzy
//
//  Created by Rachel Yee on 12/10/21.
//

import Foundation

struct UserStruct: Codable, Identifiable {
    let id: String
    var isActive: Bool
    let name: String
    var age: Int
    var company: String
    var email: String
    var address: String
    var about: String
    var registered: String
    var tags: [String]
    var friends: [FriendStruct]
}
