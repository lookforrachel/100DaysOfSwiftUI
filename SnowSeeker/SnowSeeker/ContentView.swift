//
//  ContentView.swift
//  SnowSeeker
//
//  Created by Rachel Yee on 3/5/22.
//

import SwiftUI

struct UserView: View {
    var body: some View {
        Group {
            Text("Name: Paul")
            Text("Country: England")
            Text("Pets: Luna & Arya")
        }
        .font(.title)
    }
    var id = "Taylor Swift"
}

struct ContentView: View {
    @Environment(\.horizontalSizeClass) var sizeClass
//    @State private var layoutVertically = false
    
    var body: some View {
        Group {
            if sizeClass == .compact {
                VStack(content: UserView.init)
//                VStack{
//                    UserView()
//                }
            } else {
                HStack(content: UserView.init)
//                HStack {
//                    UserView()
//                }
            }
        }
//        .onTapGesture {
//            layoutVertically.toggle()
//        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
