//
//  ContentView.swift
//  Flashzilla
//
//  Created by Rachel Yee on 1/30/22.
//

import CoreHaptics
import SwiftUI

struct ContentView: View {

    var body: some View {
        CardView(card: Card.example)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
