//
//  ContentView.swift
//  HotProspects
//
//  Created by Rachel Yee on 1/22/22.
//

import SwiftUI

struct ContentView: View {
    static let tag = "Two"
    @State private var selectedTab = "One"
    var body: some View {
        VStack {
            TabView(selection: $selectedTab) {
                Text("Tab 1")
                    .onTapGesture {
                        selectedTab = ContentView.tag
                    }
                    .tabItem {
                        Label("One", systemImage: "star")
                    }
                Text("Tab 2")
                    .tabItem {
                        Label("Two", systemImage: "circle")
                    }
                    .tag(ContentView.tag)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
