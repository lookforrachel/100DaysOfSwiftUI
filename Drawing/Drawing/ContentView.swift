//
//  ContentView.swift
//  Drawing
//
//  Created by Rachel Yee on 11/21/21.
//

import SwiftUI

struct Arrow: InsettableShape {
    var insetAmount = 0.0
    
    func path(in rect: CGRect) -> Path {
        var path = Path()

        path.move(to: CGPoint(x:rect.midX, y:rect.minY+insetAmount))
        path.addLine(to: CGPoint(x:rect.maxX-insetAmount, y:rect.midY))
        path.addLine(to: CGPoint(x:rect.midX+rect.width/5, y:rect.midY))
        path.addLine(to: CGPoint(x:rect.midX+rect.width/5, y:rect.maxY-insetAmount))
        path.addLine(to: CGPoint(x:rect.midX-rect.width/5, y:rect.maxY-insetAmount))
        path.addLine(to: CGPoint(x:rect.midX-rect.width/5, y:rect.midY))
        path.addLine(to: CGPoint(x:rect.minX+insetAmount, y:rect.midY))
        path.addLine(to: CGPoint(x:rect.midX, y:rect.minY+insetAmount))
        path.closeSubpath()
        
        return path
    }
    
    func inset(by amount: CGFloat) -> some InsettableShape {
        var arrow = self
        arrow.insetAmount += amount
        return arrow
    }
}

struct ContentView: View {
    @State private var lineThickness = 0.1

    var body: some View {
        
        VStack{
            Arrow()
//                    .stroke(.blue, style: StrokeStyle(lineWidth: CGFloat(lineThickness), lineCap: .round, lineJoin: .round))
                .strokeBorder(.blue, lineWidth: lineThickness)
                .frame(width: 300, height: 300)

            Slider(value: $lineThickness, in: 0.0...10.0, step: 0.1)
                    .padding()
        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

