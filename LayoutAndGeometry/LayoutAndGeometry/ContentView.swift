//
//  ContentView.swift
//  LayoutAndGeometry
//
//  Created by Rachel Yee on 2/17/22.
//

import SwiftUI

extension VerticalAlignment {
    enum MidAccountAndName: AlignmentID {
        static func defaultValue(in context: ViewDimensions) -> CGFloat {
            context[.top]
        }
    }
    static let midAccountAndName = VerticalAlignment(MidAccountAndName.self)
}

struct ContentView: View {
    var body: some View {
        HStack(alignment: .midAccountAndName) {
            VStack {
                Text("@twostraws")
                    .alignmentGuide(.midAccountAndName) { d in
                        d[VerticalAlignment.center]
                    }
                Image("Chickens")
                    .resizable()
                    .frame(width: 64, height: 64)
                Text("Full name:")
                Text("Full name:")
                Text("Full name:")
                Text("Full name:")

                
            }
            VStack{
                Text("Full name:")
                Text("Full name:")
                Text("Full name:")
                Text("Full name:")
                Text("PAUL HUDSON")
                    .alignmentGuide(.midAccountAndName) { d in
                        d[VerticalAlignment.center]}
                    .font(.largeTitle)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
