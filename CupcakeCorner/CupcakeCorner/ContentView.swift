//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Rachel Yee on 11/29/21.
//

import SwiftUI


struct ContentView: View {
    
    @StateObject var order = Order()
    
    var body: some View {
        NavigationView{
            Form {
                Section {
                    Picker("Flavour", selection: $order.type) {
                        ForEach(Order.types.indices) {
                            Text(Order.types[$0])
                        }
                    }
                    
                    Stepper("Amount \(order.quantity)", value: $order.quantity, in: 2...20)
                }
                
                Section {
                    Toggle("Special Request?", isOn: $order.specialRequestEnabled.animation())
                    
                    if order.specialRequestEnabled {
                        Toggle("Extra ", isOn: $order.extraFrosting)
                        Toggle("Sprinkles", isOn: $order.addSprinkles)
                    }
                    Section {
                        NavigationLink {
                            AddressView(order: order)
                        } label: {
                            Text("Delivery details")
                        }
                    }
                }
                
                
            }
            .navigationTitle("Cupcake Corner")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
