//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Rachel Yee on 10/24/21.
//

import SwiftUI

struct ProminentTitle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(.blue)
    }
}

extension View {
    func prominentTitleStyle () -> some View {
        modifier(ProminentTitle())
    }
}

struct FlagImage: View {
    var text: String
    
    var body: some View {
        Image(text)
            .renderingMode(.original)
            .clipShape(Capsule())
            .shadow(radius: 5)
    }
}

struct ContentView: View {
    @State private var endGame = false
    @State private var endTitle = "Game Over"
    @State private var questionCounter = 0


    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var score = 0

    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    
    @State private var correctAnswer = Int.random(in: 0...2 )
    @State private var feedback = ""
    
//    @State private var selection: Int? = nil
//    @State private var animationAmount = 0.0
//    @State private var opacityAmount = 100.0
//    @State private var scaleAmount = 1.0
    
    let labels = [
        "Estonia": "Flag with three horizontal stripes of equal size. Top stripe blue, middle stripe black, bottom stripe white",
        "France": "Flag with three vertical stripes of equal size. Left stripe blue, middle stripe white, right stripe red",
        "Germany": "Flag with three horizontal stripes of equal size. Top stripe black, middle stripe red, bottom stripe gold",
        "Ireland": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe orange",
        "Italy": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe red",
        "Nigeria": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe green",
        "Poland": "Flag with two horizontal stripes of equal size. Top stripe white, bottom stripe red",
        "Russia": "Flag with three horizontal stripes of equal size. Top stripe white, middle stripe blue, bottom stripe red",
        "Spain": "Flag with three horizontal stripes. Top thin stripe red, middle thick stripe gold with a crest on the left, bottom thin stripe red",
        "UK": "Flag with overlapping red and white crosses, both straight and diagonally, on a blue background",
        "US": "Flag with red and white stripes of equal size, with white stars on a blue background in the top-left corner"
    ]
    
    
    var body: some View {
        ZStack{
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3),
            ], center: .top, startRadius: 200, endRadius: 700)
                .ignoresSafeArea()
        
            VStack {
                Spacer()
                
                Text("Guess the Flag")
                    .prominentTitleStyle()
                VStack (spacing: 15){
                    VStack {
                            Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))

                            Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                        }
                    
                    ForEach(0..<3, id: \.self) { number in
                        Button {
                            flagTapped(number)
//                            self.selection = number
//                            self.opacityAmount = 00.25


                            withAnimation {
//                                self.animationAmount += 360
//                                self.scaleAmount = 0.5
                            }
                        } label: {
                            FlagImage(text: countries[number])
                                .accessibilityLabel(labels[countries[number], default: "Unknown"])

                        }
//                        .rotation3DEffect(.degrees(self.selection == number ? self.animationAmount : 0), axis: (x: 0, y: 1, z: 0))
//                        .opacity(self.selection == number ? 1 : self.opacityAmount)
//                        .scaleEffect(self.selection == number ? 1 : self.scaleAmount)
                    }
                }

                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Spacer()
                Spacer()
                
                Text("score: \(score)")
                .foregroundColor(.white)
                .font(.title.bold())
                
                Spacer()
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text(feedback)
        }
        .alert(endTitle, isPresented: $endGame) {
            Button("Reset", action: reset)
        } message: {
            Text("Your score is \(score). Want to play again?")
        }
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            score += 1
            feedback = "Your score is \(score)"
        } else {
            scoreTitle = "Wrong"
            feedback = "That’s the flag of \(countries[number])"
        }
        
        showingScore = true
        questionCounter += 1
        
    }
    
    func askQuestion() {
        if questionCounter == 8 {
            endGame = true
        } else {
            countries.shuffle()
            correctAnswer = Int.random(in: 0...2)
//            opacityAmount = 100
        }
    }
    
    func reset() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        questionCounter = 0
        score = 0
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
