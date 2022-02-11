//
//  Card.swift
//  Flashzilla
//
//  Created by Rachel Yee on 2/1/22.
//

import Foundation

struct Card: Codable, Identifiable {
    var id = UUID()
    let prompt: String
    let answer: String
    
    static let example = Card(prompt: "Who played the 13th doctor in Doctor Who?", answer: "Jodie Whittaker")
    
}
