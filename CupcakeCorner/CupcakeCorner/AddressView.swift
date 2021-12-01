//
//  AddressView.swift
//  CupcakeCorner
//
//  Created by Rachel Yee on 11/30/21.
//

import SwiftUI

struct AddressView: View {
    @ObservedObject var order: Order
    
    var body: some View {
        Form {
            Section {
                TextField("name", text: $order.name)
                TextField("Street address", text: $order.streetAddress)
                TextField("city", text: $order.city)
                TextField("Postal Code", text: $order.postalCode)
            }
            
            Section {
                NavigationLink {
                    CheckoutView(order: order)
                } label: {
                    Text("Checkout")
                }
            }
            .disabled(order.hasValidAddress == false)
        }
        .navigationTitle("Delivery details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            AddressView(order: Order())
        }
    }
}
