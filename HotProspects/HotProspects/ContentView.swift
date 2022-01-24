//
//  ContentView.swift
//  HotProspects
//
//  Created by Rachel Yee on 1/22/22.
//

import SwiftUI

struct ContentView: View {
    @State private var backgroundColour = Color.red
    
    var body: some View {
        Text("Hello World")
            .padding()
            .background(backgroundColour)
        
        Text("Change Colour")
            .padding()
            .contextMenu {
                Button (role: .destructive ){
                    backgroundColour = .red
                } label: {
                    Label("Red", systemImage: "checkmark.circle.fill")
                        .foregroundColor(.red)
                }
                
                Button("Green") {
                    backgroundColour = .green
                }
                Button("Blue") {
                    backgroundColour = .blue
                }
            }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
