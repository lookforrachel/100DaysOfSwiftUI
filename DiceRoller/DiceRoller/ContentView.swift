//
//  ContentView.swift
//  DiceRoller
//
//  Created by Rachel Yee on 2/21/22.
//

import SwiftUI

struct ContentView: View {
    @State private var rolledNumber = 1
    @State private var diceSides = 3
    
    var body: some View {
        VStack {
            Text(String(rolledNumber))
                .font(.largeTitle)
            Button("Roll Dice") {
                rolledNumber = Int.random(in: 1..<diceSides+1)
            }
            Stepper("Dice sides: \(diceSides)", value: $diceSides, in: 3...100)
                .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
