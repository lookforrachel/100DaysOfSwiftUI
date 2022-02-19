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
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 0) {
                ForEach(1..<20) { num in
                    GeometryReader { geo in
                        Text("Number \(num)")
                            .font(.largeTitle)
                            .padding()
                            .background(.red)
                        // proxy's frame in the global namespace, give me the left edge, the-x value from that. Give me a fraction of tt - / 8.
                            .rotation3DEffect(.degrees(-geo.frame(in: .global).minX) / 8, axis: (x: 0, y: 1, z: 0))
                    }
                    .frame(width: 200, height: 200)
                }
            }
        }
        
//        // reads all available screen space
//        GeometryReader { fullView in
//            ScrollView {
//                ForEach(0..<50) { index in
//
//                    // reads current screen space for internal height row
//                    GeometryReader { geo in
//                        Text("Row #\(index)")
//                            .font(.title)
//                            .frame(maxWidth: .infinity)
//                            .background(colors[index % 7])
//
//                        // minY - half available size / 5
//                            .rotation3DEffect(.degrees(geo.frame(in: .global).minY - fullView.size.height / 2) / 5, axis: (x: 0, y: 1, z: 0))
//
//                    }
//                    .frame(height: 40)
//                }
//            }
//        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
