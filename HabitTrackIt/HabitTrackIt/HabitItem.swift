//
//  HabitItem.swift
//  HabitTrackIt
//
//  Created by Rachel Yee on 11/26/21.
//

import Foundation

struct HabitItem: Identifiable, Codable, Equatable {
    var id = UUID()
    var name: String
    var type: String
    var description: String
    var amount: Int
    var count: Int
}
