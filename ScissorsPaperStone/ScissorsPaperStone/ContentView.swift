//
//  ContentView.swift
//  ScissorsPaperStone
//
//  Created by Rachel Yee on 10/29/21.
//

import SwiftUI

struct BigIcon: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 150))
    }
}

extension View {
    func bigIconStyle () -> some View {
        modifier(BigIcon())
    }
}

struct ContentView: View {
    
    @State private var options = ["✂️", "📄", "🪨"]
    @State private var randomMove = Int.random(in: 0..<3)
    @State private var shouldWin = Bool.random()
    
    @State private var score = 0
    @State private var questionCounter = 1
    @State private var endTitle = "The End"
    @State private var endGame = false
    
    @State private var correctAnswer = 0
    @State private var useRedBackground = false
    
    var body: some View {
        ZStack{
            Color(useRedBackground ? .red : .green)
                .ignoresSafeArea()
            VStack {
                
                VStack (alignment: .leading) {
                    Text("Score:\(score)")
                }
                
                Spacer()
                
                HStack(spacing: 40){
                    Text("Round \(questionCounter):")
                    Text(options[randomMove])
                        .font(.system(size: 60))
                    Text(shouldWin ? "WIN" : "LOSE")
                        .fontWeight(.bold)
                }
                
                Spacer()
                
                VStack{
                    ForEach(0..<3) { number in
                        Button {
                            gameLogic(number)
                            checkEndGame()
                        } label: {
                           Text(options[number])
                                .bigIconStyle()
                        }
                    }
                }
                
                Spacer()
                
            }
        }
        .alert(endTitle, isPresented: $endGame) {
            Button("Play Again", action: reset)
        } message: {
            Text("Your score is \(score).")
        }
    }
    
    func toggle() {
        randomMove = Int.random(in: 0..<3)
        shouldWin = Bool.random()
    }
    
    func reset () {
        questionCounter = 0
        score = 0
        endGame = false
        toggle()
    }
    
    func checkEndGame () {
        if questionCounter == 8 {
            endGame = true
        } else {
            toggle()
            
        }
    }
    
    func gameLogic(_ number: Int){
        if randomMove == 0 {
            if shouldWin == true {
                correctAnswer = 2
            } else {
                correctAnswer = 1
            }
        }
        if randomMove == 1 {
            if shouldWin == true {
                correctAnswer = 0
            } else {
                correctAnswer = 2
            }
        }
        if randomMove == 2 {
            if shouldWin == true {
                correctAnswer = 1
            } else {
                correctAnswer = 0
            }
        }
        
        if number == correctAnswer {
            score += 1
            questionCounter += 1
            useRedBackground = false

        } else {
            useRedBackground = true
            questionCounter += 1
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    
    
    }
}
