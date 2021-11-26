//
//  ColorCyclingRectangleView.swift
//  Drawing
//
//  Created by Rachel Yee on 11/26/21.
//

import SwiftUI

struct ColorCyclingCircle: View {
    var amount = 0.0
    var steps = 100
    var gradientX = 0.0
    var gradientY = 0.0

    var body: some View {
        ZStack {
            ForEach(0..<steps) { value in
                Rectangle()
                    .inset(by: Double(value))
//                    .strokeBorder(color(for: value, brightness: 1), lineWidth: 2)
                    .strokeBorder(
                        LinearGradient(
                            gradient: Gradient(colors: [
                                color(for: value, brightness: 1),
                                color(for: value, brightness: 0.5)
                            ]),
                            startPoint: .init(x: 0+gradientX, y: 0+gradientY),
                            endPoint: .bottom
                        ),
                        lineWidth: 2
                    )
            }
        }
    }

    func color(for value: Int, brightness: Double) -> Color {
        var targetHue = Double(value) / Double(steps) + amount

        if targetHue > 1 {
            targetHue -= 1
        }

        return Color(hue: targetHue, saturation: 1, brightness: brightness)
    }
}

struct ColorCyclingRectangleView: View {
    @State private var colorCycle = 0.0
    @State private var x = 0.0
    @State private var y = 0.0
    
    var body: some View {
        
        VStack {
            ColorCyclingCircle(amount: colorCycle, gradientX: x, gradientY: y)
                .frame(width: 300, height: 300)

            Slider(value: $colorCycle)
                .padding()

            Slider(value: $x)
                .padding()

            Slider(value: $y)
                .padding()
        }
    }
}

struct ColorCyclingRectangleView_Previews: PreviewProvider {
    static var previews: some View {
        ColorCyclingRectangleView()
    }
}
