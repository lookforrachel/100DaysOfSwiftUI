//
//  ContentView.swift
//  BucketList
//
//  Created by Rachel Yee on 12/18/21.
//

import SwiftUI

struct ContentView: View {

    @State private var message: String = FileManager.default.decode("message.txt")
    
    var body: some View {
        Text("Hello World")
            .onTapGesture {
                
                let str = "Test message"
                let url = getDocumentDirectory().appendingPathComponent("message.txt")
                do {
                    try str.write(to:url, atomically: true, encoding: .utf8)
                    
                    let input = try String(contentsOf: url)
                    print(input)
                } catch {
                    print(error.localizedDescription)
                }
            }
        
        Text(message)
        
    

    }
    
    func getDocumentDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
