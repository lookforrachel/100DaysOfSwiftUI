//
//  ContentView.swift
//  FunTimesTables
//
//  Created by Rachel Yee on 11/10/21.
//

import SwiftUI

struct Question {
    let first: Int
    let second: Int
    
    var question: String {
        let questionSentence = "\(first) x \(second)"
        return questionSentence
    }
    var answer: Int {
        let multiplied = first * second
        return multiplied
    }
}

struct ContentView: View {
    
    @State private var selectedNumbers = 2
    @State private var selectedQuestions = 5
    
    let multiplicationRange = 2...12
    let questionRange = 5...15
        
    @State private var firstNumber = 1
    @State private var secondNumber = 2
    
    @State private var userAnswer: Int? = 0
    @State private var correctAnswer = 0
    @State private var fullAnswer = ""
    
    @State private var showingAlert = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var score = 0
    @State private var questionCount = 0
    @State private var endGame = false
    
    @State private var isShowingGame = false
    @State private var isShowingSettings = true
    @State private var isShowingEndScreen = false
    
    @State private var wrong = false
    
    @State private var questionsArray = [String]()
    @State private var answersArray = [Int]()
    
    @State private var buttonAnimation = 1.0
    @State private var wordAnimation = 1.0

//    @State private var keypad = [1,2,3,4,5,6,7,8,9,0]
    
    var settingsScreen: some View {
        NavigationView {
        ZStack {
            Color(red: 0.9, green: 0.7, blue: 0.3)
                    .ignoresSafeArea()
                VStack {
                    Spacer()
                
                    Group {
                        Text("Times tables up to")
                        Text("\(selectedNumbers)").frame(width:200).padding(2)
                            Stepper("", value: $selectedNumbers,
                                    in: multiplicationRange,
                                    step: 1)
                            .frame(width:100).padding(20)
                        Spacer()
                    }
                    
                    Group {
                        Text("Number of questions")
                        Text("\(selectedQuestions)")
                        .frame(width:200).padding(2)
                        Stepper("", value: $selectedQuestions,
                                in: questionRange,
                                step: 5).frame(width:100).padding(20)
                    }
                    Spacer()
                        Button("Start") {
                            buttonAnimation += 0.5
                            wordAnimation += 180
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                newGame()
                                wordAnimation = 0
                            }
                        }
                        .padding(50)
                        .background(.purple)
                        .foregroundColor(.white)
                        .clipShape(Circle())
                        .scaleEffect(buttonAnimation)
                        .rotation3DEffect(.degrees(wordAnimation), axis: (x: 0, y: 0, z: 1))
                        .animation(.interpolatingSpring(stiffness: 50, damping: 1),value: buttonAnimation)
                    Spacer()

                }
        }
        .navigationTitle("FUN TIMES tables!")
        .toolbar {
            Text("Score: \(score)")
        }
        }
    }
    
    var gameScreen: some View {
        ZStack {
        Color(red: 0.9, green: 0.7, blue: 0.3)
                .ignoresSafeArea()
                VStack {
                    if !showingAlert && !endGame {
                        VStack {
                            Text($questionsArray[questionCount-1].wrappedValue)
                            TextField("Answer:", value: $userAnswer, format: .number).padding(70)
                                .keyboardType(.numberPad)
                            
//                            ForEach(0..<11, id: \.self) { number in
//                                Button {
//                                  keypadPress()
//                                } label: {
//                                    Image(systemName: "\(keypad[number]).circle")
//                                }
//                            }
                            
                            Button("Submit") {
                                checkAnswer()
                                withAnimation{
                                wordAnimation += 360
                                }
                            }
                            .rotation3DEffect(.degrees(wordAnimation),
                                               axis: (x: 0, y: 0, z: 1))
                        }
                    }
                    
                    if showingAlert {
                        ZStack {
                            Color(wrong ? .red : .green)
                                .ignoresSafeArea()
                            VStack {
                                Spacer()
                                
                                Text(alertTitle)
//                                    .onAppear(perform: {wordAnimation += 360})
                                    .rotation3DEffect(.degrees(wordAnimation),
                                                      axis: (x: 0, y: 0, z: 1))
                                
                                Spacer()
                                Text(alertMessage)
                                Spacer()
                                Button ("OK") {
                                    if questionCount != selectedQuestions {
                                        newQuestion()
                                        showingAlert = false
                                        wrong = false
                                        wordAnimation = 0
                                    } else {
                                        showingAlert = false
                                        endGame = true

                                    }
                                }
                                Spacer()

                                }
                        }
                    }
                    if endGame {
                        ZStack {
                            VStack{
                                Text("Your score is \(score)")
                                HStack {
                                    Button("OK"){
                                        isShowingSettings = true
                                        isShowingGame = false
                                    }                                    
                                    Button("Play Again"){
                                        newGame()
                                    }
                                }
                                
                            }
                        }
                    }
            }
        }
    }
    
    var body: some View {
        
        if isShowingSettings {
            settingsScreen
        }
        
        if isShowingGame {
            gameScreen
        }
    }
    
    func generateQuestions() {
        
        let rangeOfMultiplications = 1...selectedNumbers
                
        for _ in 0..<selectedQuestions {
            let questionInstance = Question.init(first: Int.random(in: rangeOfMultiplications), second: Int.random(in: rangeOfMultiplications))
            
            questionsArray.append(questionInstance.question)
            answersArray.append(questionInstance.answer)
        }
    }
    
    func newQuestion() {
        if questionCount == selectedQuestions {
            endGame = true
        } else {
            firstNumber = Int.random(in: 1...selectedNumbers)
            secondNumber = Int.random(in: 1...selectedNumbers)
            // if answer is correct from previous question, even if correct it won't be correct for next answer
            userAnswer = nil
            questionCount += 1
        }
    }
    
    func checkAnswer() {
//        correctAnswer = firstNumber * secondNumber
//
//        if userAnswer == correctAnswer {
//            alertTitle = "Correct!"
//            alertMessage = "\(firstNumber) x \(secondNumber) = \(correctAnswer)"
//            score += 1
//            wrong = false
//        } else {
//            alertTitle = "WRONG!!"
//            alertMessage = "\(firstNumber) x \(secondNumber) = \(correctAnswer)"
//            wrong = true
//        }
//        showingAlert = true
        
        correctAnswer = answersArray[questionCount-1]
        fullAnswer = "\(questionsArray[questionCount-1]) = \(correctAnswer)"
        
        if userAnswer == correctAnswer {
            alertTitle = "CORRECT!"
            alertMessage = fullAnswer
            score += 1
            wrong = false
        } else {
            alertTitle = "WRONG!"
            alertMessage = fullAnswer
            wrong = true
        }
        
        showingAlert = true
    }
    
    func reset() {
        score = 0
        questionCount = 0
        isShowingGame = false
        isShowingSettings = true
        
        questionsArray.removeAll()
        answersArray.removeAll()
    }
    
    func newGame() {
        reset()
        newQuestion()
        isShowingGame = true
        isShowingSettings = false
        endGame = false
        generateQuestions()
        
    }
    
    func spin() {
        wordAnimation += 360
    }
    
//    func keypadPress(_ number: Int) {
//        userInput += String(number)
//    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
