//
//  ContentView.swift
//  FunTimesTables
//
//  Created by Rachel Yee on 11/10/21.
//

import SwiftUI

struct ContentView: View {

    @State private var selectedNumbers = 2
    @State private var selectedQuestions = 5

    let multiplicationRange = 2...12
    let questionRange = 5...15

    @State private var firstNumber = 1
    @State private var secondNumber = 2

    @State private var userAnswer = 0
    @State private var correctAnswer = 0

    @State private var showingAlert = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var score = 0
    @State private var questionCount = 0
    @State private var endGame = false

    @State private var isShowingGame = false
    @State private var isShowingSettings = true

    var body: some View {
        NavigationView {
            Form {
                if isShowingSettings {
                    Text("Fun Times Tables")

                    Section {
                        Stepper("\(selectedNumbers)", value: $selectedNumbers,
                                in: multiplicationRange,
                                step: 1)
                    }
                header: {
                    Text("Times tables up to")
                }

                    Section {
                        Stepper("\(selectedQuestions)", value: $selectedQuestions,
                                in: questionRange,
                                step: 5)
                    }
                    header: {
                        Text("Number of questions")
                    }

                    Section {
                        Button("Start Game") {
                            newQuestion()
                            isShowingGame = true
                            isShowingSettings = false
                        }
                    }

                }
                if isShowingGame {
                    HStack {
                        Text("Score: \(score)")
                    }

                    Section {
                        Text("Q\(questionCount): \(firstNumber) x \(secondNumber)")
                        TextField("Answer:", value: $userAnswer, formatter: NumberFormatter())
                    }
                    Button("Submit") {
                        checkAnswer()
                        print(userAnswer)
                    }
                }
            }
            .navigationTitle("Fun Times Tables")
            .toolbar {
                HStack {
                    Text("Score: \(score)")
                }
            }
            .alert(alertTitle, isPresented: $showingAlert) {
                Button("Next", action: newQuestion)
            } message: {
                Text(alertMessage)
            }
            .alert("All Done!", isPresented: $endGame) {
                Button("OK", action: reset)
            } message: {
                Text("Your score is \(score)")
            }
        }
    }

    func newQuestion() {
        if questionCount == selectedQuestions {
            endGame = true
        } else {
            firstNumber = Int.random(in: 1...selectedNumbers)
            secondNumber = Int.random(in: 1...selectedNumbers)
            // if answer is correct from previous question, even if correct it won't be correct for next answer
            questionCount += 1
        }
    }

    func checkAnswer() {
        correctAnswer = firstNumber * secondNumber

        if userAnswer == correctAnswer {
            alertTitle = "Correct!"
            alertMessage = "\(firstNumber) x \(secondNumber) = \(correctAnswer)"
            score += 1
        } else {
            alertTitle = "WRONG!!"
            alertMessage = "\(firstNumber) x \(secondNumber) = \(correctAnswer)"
        }
        showingAlert = true
    }

    func reset() {
        score = 0
        questionCount = 0
        isShowingGame = false
        isShowingSettings = true
    }


}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
