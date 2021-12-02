//
//  UserOrder.swift
//  CupcakeCorner
//
//  Created by Rachel Yee on 12/2/21.
//

import Foundation

class UserOrder: ObservableObject {
    @Published var currentOrder: Order
    
    init() {
        self.currentOrder = Order()
    }
}
