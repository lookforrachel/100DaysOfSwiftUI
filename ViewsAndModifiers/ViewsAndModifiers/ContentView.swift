//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Rachel Yee on 10/26/21.
//

import SwiftUI


struct ContentView: View {
    @State private var useRedText = false
    
    // Custom modifiers
    struct Watermark: ViewModifier {
        var text: String

        func body(content: Content) -> some View {
            ZStack(alignment: .bottomTrailing) {
                content
                Text(text)
                    .font(.caption)
                    .foregroundColor(.white)
                    .padding(5)
                    .background(.black)
            }
        }
    }

    extension View {
        func watermarked(with text: String) -> some View {
            modifier(Watermark(text: text))
        }
    }
    
    // View Composition
    struct CapsuleText: View {
        var text: String

        var body: some View {
            Text(text)
                .font(.largeTitle)
                .padding()
                .foregroundColor(.white)
                .background(.blue)
                .clipShape(Capsule())
        }
    }
    
    // Views as properties
    var spells: some View {
        Group {
            Text("Lumos")
            Text("Obliviate")
        }
    }
    
    @ViewBuilder var spellz: some View {
        Text("Lumos")
        Text("Obliviate")
    }
    
    
    var body: some View {
        
        // Custom Modifiers – Watermarked
        Color.blue
            .frame(width: 300, height: 200)
            .watermarked(with: "Hacking with Swift")
        
        // Nothing is 'behind' the SwiftUI view
        Text("Hello, world!")
            .frame(maxWidth: .infinity,  maxHeight: .infinity)
            .background(.red)
        
        // View Composition
        VStack(spacing: 10) {
            CapsuleText(text: "First")
                .foregroundColor(.white)
            CapsuleText(text: "Second")
                .foregroundColor(.yellow)
        }
        
        // Modifier order matters
        Button("The button"){
            print(type(of: self.body))
        }
        .frame(width: 200, height: 200)
        .background(.red)
        
        Text("Concentric Squares")
            .padding()
            .background(.red)
            .padding()
            .background(.blue)
            .padding()
            .background(.green)
            .padding()
            .background(.yellow)
        
     // Conditional modifiers – use ternary operator when possible as if statements are less efficient
        Button("Hello World") {
            // flip the Boolean between true and false
            useRedText.toggle()
        }
        .foregroundColor(useRedText ? .red : .blue)
        
        HStack{
    //  Font IS an environment modifier

        VStack {
            Text("Gryffindor")
                .font(.largeTitle)
            Text("Hufflepuff")
            Text("Ravenclaw")
            Text("Slytherin")
        }
        .font(.title)
        
    // Blur is not an environment modifier
        VStack {
            Text("Gryffindor")
                .blur(radius: 0)
            Text("Hufflepuff")
            Text("Ravenclaw")
            Text("Slytherin")
        }
        .blur(radius: 5)
        }
    
        //

        
        
        
        
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
