//
//  Order.swift
//  CupcakeCorner
//
//  Created by Rachel Yee on 11/30/21.
//

import SwiftUI

    struct Order: Codable {
//        enum CodingKeys: CodingKey {
//            case type, quantity, extraFrosting, addSprinkles, name, streetAddress, city, postalCode
//        }
        
        static let types = ["Vanilla", "Chocolate", "Red Velvet", "Rainbow"]
         var type = 0
         var quantity = 2
        
         var specialRequestEnabled = false {
            didSet {
                if specialRequestEnabled == false {
                    extraFrosting = false
                    addSprinkles = false
                }
            }
        }
         var extraFrosting = false
         var addSprinkles = false
        
         var name = ""
         var streetAddress = ""
         var city = ""
         var postalCode = ""
        
        var hasValidAddress: Bool {
            if name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || streetAddress.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || city.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || postalCode.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                return false
            }
            return true
        }
        
        var cost: Double {
            //$2 per cupcake
            var cost = Double(quantity) * 2
            
            //special cupcakes cost more
            cost += (Double(type) / 2)
            
            //$1/cupcake for extra frosting
            if extraFrosting {
                cost += Double(quantity)
            }
            
            //$0.50/cupcake for extra frosting
            if addSprinkles {
                cost += Double(quantity) / 2
            }
                
            return cost
        }
        
//        init() { }
//
//        func encode(to encoder: Encoder) throws {
//            var container = encoder.container(keyedBy: CodingKeys.self)
//
//            try container.encode(type, forKey: .type)
//            try container.encode(quantity, forKey: .quantity)
//
//            try container.encode(extraFrosting, forKey: .extraFrosting)
//            try container.encode(addSprinkles, forKey: .addSprinkles)
//
//            try container.encode(name, forKey: .name)
//            try container.encode(streetAddress, forKey: .streetAddress)
//            try container.encode(city, forKey: .city)
//            try container.encode(postalCode, forKey: .postalCode)
//        }
//
//        required init(from decoder: Decoder) throws {
//            let container = try decoder.container(keyedBy: CodingKeys.self)
//
//            type = try container.decode(Int.self, forKey: .type)
//            quantity = try container.decode(Int.self, forKey: .quantity)
//            extraFrosting = try container.decode(Bool.self, forKey: .extraFrosting)
//            addSprinkles = try container.decode(Bool.self, forKey: .addSprinkles)
//            name = try container.decode(String.self, forKey: .name)
//            streetAddress = try container.decode(String.self, forKey: .streetAddress)
//            city = try container.decode(String.self, forKey: .city)
//            postalCode = try container.decode(String.self, forKey: .postalCode)
//
//        }
    }

