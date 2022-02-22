//
//  ContentView.swift
//  LayoutAndGeometry
//
//  Created by Rachel Yee on 2/17/22.
//

import SwiftUI

struct ContentView: View {
    let colors: [Color] = [.red, .green, .blue, .orange, .pink, .purple, .yellow]

    var body: some View {
        // reads all available screen space
        GeometryReader { fullView in
            ScrollView {
                ForEach(0..<50) { index in
                    
                    // reads current screen space for internal height row
                    GeometryReader { geo in
                        Text("Row #\(index), geo: \(geo.frame(in: .global).minY / 200)")
//                            .font(.title)
//                            .frame(maxWidth: .infinity)
                            .frame(width: abs(geo.frame(in: .global).minY))
//                            .background(colors[index % 7])
                            .background(Color(hue: geo.frame(in: .global).minY / 600, saturation: 1.0, brightness: 0.5)
)
                            .opacity(abs(geo.frame(in: .global).minY / 200))

                        // minY - half available size / 5
                            .rotation3DEffect(.degrees(geo.frame(in: .global).minY - fullView.size.height / 2) / 5, axis: (x: 0, y: 1, z: 0))
                            

                    }
                    .frame(height: 40)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
