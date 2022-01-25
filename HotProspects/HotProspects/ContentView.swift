//
//  ContentView.swift
//  HotProspects
//
//  Created by Rachel Yee on 1/22/22.
//
import SamplePackage
import SwiftUI
import UserNotifications

struct ContentView: View {
    let possibleNumbers = Array(1...60)
    
    var body: some View {
        VStack {
            Text(results)
        }
        
    }
    var results: String {
        let selected = possibleNumbers.random(7).sorted()
        let strings = selected.map(String.init)
        return strings.joined(separator: ", ")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
