//
//  ContentView.swift
//  SnowSeeker
//
//  Created by Rachel Yee on 3/5/22.
//

import SwiftUI

struct ContentView: View {
    @State private var searchText = ""
    let allNames = ["Subh", "Vina", "Melvin", "Stefanie"]
    
    var body: some View {
        NavigationView {
            List(filteredNames, id:\.self) { name in
                Text(name)
            }
                .searchable(text: $searchText, prompt: "Look for something")
                .navigationTitle("Searching")
        }
    }
    var filteredNames: [String] {
        if searchText.isEmpty {
            return allNames
        } else {
            return allNames.filter {$0.localizedCaseInsensitiveContains(searchText)}
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
