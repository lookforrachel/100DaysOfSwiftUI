//
//  HabitItem.swift
//  HabitTrackIt
//
//  Created by Rachel Yee on 11/26/21.
//

import Foundation

struct HabitItem: Identifiable, Codable, Equatable {
    var id = UUID()
    let name: String
    let type: String
    let description: String
    let amount: Int
    var count: Int
}
