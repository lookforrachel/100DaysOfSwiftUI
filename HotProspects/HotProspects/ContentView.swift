//
//  ContentView.swift
//  HotProspects
//
//  Created by Rachel Yee on 1/22/22.
//

import SwiftUI

struct ContentView: View {
    @State private var output = ""
    
    var body: some View {
        Text("Value is \(output)")
            .task {
                await fetchReadings()
            }
    }
    
    func fetchReadings() async {
        let fetchTask = Task { () -> String in
            let url = URL(string: "https://hws.dev/readings.json")!
            let (data, _) = try await URLSession.shared.data(from: url)
            let readings = try JSONDecoder().decode([Double].self, from: data)
            return "Found \(readings.count) readings"
        }
        let result = await fetchTask.result
        
//        do {
//            output = try result.get()
//        } catch {
//            print("Download error")
//        }
        
        switch result {
        case .success(let str):
            output = str
        
        case .failure(let error):
            output = "Download error: \(error.localizedDescription))"
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
