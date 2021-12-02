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
                    Picker("Flavour", selection: $order.currentOrder.type) {
                        ForEach(MyOrder.types.indices) {
                            Text(MyOrder.types[$0])
                        }
                    }
                    
                    Stepper("Amount \(order.currentOrder.quantity)", value: $order.currentOrder.quantity, in: 2...20)
                }
                
                Section {
                    Toggle("Special Request?", isOn: $order.currentOrder.specialRequestEnabled.animation())
                    
                    if order.currentOrder.specialRequestEnabled {
                        Toggle("Extra ", isOn: $order.currentOrder.extraFrosting)
                        Toggle("Sprinkles", isOn: $order.currentOrder.addSprinkles)
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
