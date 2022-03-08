//
//  ContentView.swift
//  SnowSeeker
//
//  Created by Rachel Yee on 3/5/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView{
            NavigationLink {
                Text("New secondary")
            } label: {
                Text("Hello, world!")
            }
                .navigationTitle("Primary")
            
            Text("Secondary")
            
            Text("Tertiary")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
