//
//  ExpenseItem.swift
//  iExpense
//
//  Created by Rachel Yee on 11/15/21.
//

import Foundation
import SwiftUI


struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
    
    func expenseStyle() -> Color {
        if amount < 10 {
            return Color.green
        } else if amount < 100 {
            return Color.blue
        } else {
            return Color.red
        }
    }
}

