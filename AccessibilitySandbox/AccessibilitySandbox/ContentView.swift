//
//  ContentView.swift
//  AccessibilitySandbox
//
//  Created by Rachel Yee on 12/29/21.
//

import SwiftUI

struct ContentView: View {

    
    var body: some View {
//        Image(decorative: "character")
//            .accessibilityHidden(true)
        
        VStack {
            Text("Your score is")
            Text("1000")
                .font(.title)
        }
//        .accessibilityElement(children: .combine)
        .accessibilityElement(children: .ignore)
        .accessibilityLabel("Your score is 1000")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
