//
//  AddressView.swift
//  CupcakeCorner
//
//  Created by Rachel Yee on 11/30/21.
//

import SwiftUI

struct AddressView: View {
    @ObservedObject var order: UserOrder
    
    var body: some View {
        Form {
            Section {
                TextField("name", text: $order.currentOrder.name)
                TextField("Street address", text: $order.currentOrder.streetAddress)
                TextField("city", text: $order.currentOrder.city)
                TextField("Postal Code", text: $order.currentOrder.postalCode)
            }
            
            Section {
                NavigationLink {
                    CheckoutView(order: order)
                } label: {
                    Text("Checkout")
                }
            }
            .disabled(order.currentOrder.hasValidAddress == false)
        }
        .navigationTitle("Delivery details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            AddressView(order: UserOrder())
        }
    }
}
