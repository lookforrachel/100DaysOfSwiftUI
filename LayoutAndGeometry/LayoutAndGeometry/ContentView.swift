//
//  ContentView.swift
//  LayoutAndGeometry
//
//  Created by Rachel Yee on 2/17/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Text("Hellow")
            .offset(x: 100, y: 100)
//            .position(x: 100, y: 100)
            .background(.red)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
