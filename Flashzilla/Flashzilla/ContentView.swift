//
//  ContentView.swift
//  Flashzilla
//
//  Created by Rachel Yee on 1/30/22.
//

import SwiftUI

struct ContentView: View {
    @State private var offset = CGSize.zero
    @State private var isDragging = false
    
//    @State private var currentAmount = Angle.zero
//    @State private var finalAmount = Angle.zero
    
//    @State private var currentAmount = 0.0
//    @State private var finalAmount = 1.0
 
    var body: some View {
        let dragGesture = DragGesture()
            .onChanged { value in
                offset = value.translation
            }
            .onEnded { _ in
                withAnimation {
                    offset = .zero
                    isDragging = false
                }
            }
        let pressGesture = LongPressGesture()
            .onEnded { value in
                withAnimation {
                    isDragging = true
                }
            }
        let combined = pressGesture.sequenced(before: dragGesture)
        
        Circle()
            .fill(.red)
            .frame(width: 64, height: 64)
            .scaleEffect(isDragging ? 1.5 : 1)
            .offset(offset)
            .gesture(combined)
        
//        VStack {
//            Text("Hello, world!")
//                .onTapGesture {
//                    print("Text tapped!")
//                }
//        }
//        .simultaneousGesture(
//            TapGesture()
//                .onEnded{
//                print("VStack tapped!")
//            }
//        )
  
        
//        .highPriorityGesture(
//            TapGesture()
//                .onEnded{
//                print("VStack tapped!")
//            }
//        )
        
        
        
//            .rotationEffect(currentAmount + finalAmount)
//            .gesture(
//                RotationGesture()
//                    .onChanged { angle in
//                        currentAmount = angle
//                    }
//                    .onEnded { angle in
//                        finalAmount += currentAmount
//                        currentAmount = .zero
//                    }
//            )
        
//            .scaleEffect(finalAmount + currentAmount)
//            .gesture (
//                MagnificationGesture()
//                    .onChanged { amount in
//                        print(amount)
//                        currentAmount = amount - 1
//                    }
//                    .onEnded { amount in
//                        print(amount)
//                        finalAmount += currentAmount
//                        currentAmount = 0
//                    }
//            )
        
        
//            .onTapGesture(count: 2) {
//                print("Double tapped!")
//            }
//            .onLongPressGesture {
//                print("Long pressed!")
//            }
//            .onLongPressGesture(minimumDuration: 1) {
//                print("Long pressed!")
//            } onPressingChanged: { inProgress in
//                print("In progress: \(inProgress)!")
//            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
