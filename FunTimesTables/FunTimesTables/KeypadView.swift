//
//  KeypadView.swift
//  FunTimesTables
//
//  Created by Rachel Yee on 12/4/21.
//

import SwiftUI

struct CustomButton: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(Font.custom("Shrikhand-Regular", size: 40))
            .font(.largeTitle)
            .foregroundColor(.white)
            .frame(width: 60, height: 60)
            .background(.red)
            .clipShape(Circle())
    }
}

extension View {
    func buttonStyle() -> some View {
        modifier(CustomButton())
    }
}

struct KeypadView: View {
    @State private var userInput = ""

    
    var body: some View {
        NavigationView {
            VStack {
                
                
                
                HStack {
                    ForEach(1..<4) { number in
                            Button ("\(number)") {
                                keypadPress(for: number)
                            }
                            .buttonStyle()
                    }
                }
                
                HStack {
                    ForEach(4..<7) { number in
                            Button ("\(number)") {
                                keypadPress(for: number)
                            }
                            .buttonStyle()
                    }
                }
                
                HStack {
                    ForEach(7..<10) { number in
                            Button ("\(number)") {
                                keypadPress(for: number)
                            }
                            .buttonStyle()
                    }
                }
                
                HStack {
                            Button ("\(0)") {
                                keypadPress(for: 0)
                            }
                            .buttonStyle()
                }
            }
            .navigationTitle("Fun Times (tables)")
            .font(Font.custom("Shrikhand-Regular", size: 50))
        }
    }
    
    func keypadPress(for number: Int) {
        userInput += String(number)
        print(userInput)
    }
}

struct keypadView_Previews: PreviewProvider {
    static var previews: some View {
        KeypadView()
    }
}
