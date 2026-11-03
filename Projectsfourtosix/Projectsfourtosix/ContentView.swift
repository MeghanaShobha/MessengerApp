import SwiftUI

struct Question {
    let firstNumber: Int
    let secondNumber: Int
    let answer: Int
    var text: String {
        "\(firstNumber) × \(secondNumber)"
    }
}
struct ContentView: View {
    @State private var isGameActive = false
    @State private var isGameOver = false
    @State private var selectedTable = 2
    @State private var numberOfQuestions = 5
    @State private var questions: [Question] = []
    @State private var questionNumber = 0
    @State private var score = 0
    @State private var userAnswer = ""
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(colors: [.white.opacity(0.7), .blue.opacity(0.7)], startPoint: .topLeading, endPoint: .bottomTrailing)
                    .ignoresSafeArea()
                if !isGameActive && !isGameOver {
                    SettingsView(selectedTable: $selectedTable, numberOfQuestions: $numberOfQuestions, startGame: startGame)
                } else if isGameActive {
                    GameView(question: questions[questionNumber], questionNumber: questionNumber, totalQuestions: numberOfQuestions, score: score, userAnswer: $userAnswer, submitAnswer: submitAnswer)
                } else if isGameOver {
                    ResultsView(score: score, totalQuestions: numberOfQuestions, playAgain: playAgain)
                }
            }
            .navigationTitle("Math Fun")
        }
    }
    func startGame() {
        questions.removeAll()
        score = 0
        questionNumber = 0
        userAnswer = ""
        for _ in 0..<numberOfQuestions {
            let firstNumber = Int.random(in: 1...selectedTable)
            let secondNumber = Int.random(in: 1...12)
            let question = Question(firstNumber: firstNumber, secondNumber: secondNumber, answer: firstNumber * secondNumber)
            questions.append(question)
        }
        isGameActive = true
        isGameOver = false
    }
    func submitAnswer() {
        guard let answer = Int(userAnswer) else {
            return
        }
        if answer == questions[questionNumber].answer {
            score += 1
        }
        userAnswer = ""
        if questionNumber + 1 == numberOfQuestions {
            isGameActive = false
            isGameOver = true
        } else {
            questionNumber += 1
        }
    }
    func playAgain() {
        isGameActive = false
        isGameOver = false
        score = 0
        questionNumber = 0
        userAnswer = ""
    }
}
struct SettingsView: View {
    @Binding var selectedTable: Int
    @Binding var numberOfQuestions: Int
    var startGame: () -> Void
    var body: some View {
        VStack(spacing: 30) {
            Spacer()
           Text("Practice your multiplication tables!")
                .font(.headline)
                .foregroundStyle(.black.opacity(0.9))
                .multilineTextAlignment(.center)
            VStack(spacing: 20) {
                VStack {
                    Text("Practice tables up to")
                        .font(.headline)
                    Stepper("Up to \(selectedTable)", value: $selectedTable, in: 2...20)
                        .padding()
                        .background(.white.opacity(0.9))
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                }
                VStack(spacing: 15) {
                    Text("Number of Questions")
                        .font(.headline)
                    HStack(spacing: 15) {
                        ForEach([5, 10, 20], id: \.self) { number in
                            Button {
                                numberOfQuestions = number
                            } label: {
                                Text("\(number)")
                                    .font(.title2.bold())
                                    .frame(width: 70, height: 55)
                                    .background(numberOfQuestions == number ? Color.green : Color.white)
                                    .foregroundStyle(numberOfQuestions == number ? .white : .black)
                                    .clipShape(RoundedRectangle(cornerRadius: 15))
                            }
                        }
                    }
                }
            }
            .padding()
            Button(action: startGame) {
                Text("Start Game")
                    .font(.title2.bold())
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(.indigo.opacity(0.7))
                    .clipShape(RoundedRectangle(cornerRadius: 20))
            }
            .padding(.horizontal, 30)
            Spacer()
        }
        .padding()
    }
}
struct GameView: View {
    let question: Question
    let questionNumber: Int
    let totalQuestions: Int
    let score: Int
    @Binding var userAnswer: String
    var submitAnswer: () -> Void
    var body: some View {
        VStack(spacing: 30) {
            Text("Question \(questionNumber + 1) of \(totalQuestions)")
                .font(.headline)
                .foregroundStyle(.black)
            Text("Score: \(score)")
                .font(.title3.bold())
                .foregroundStyle(.black)
            Spacer()
            VStack(spacing: 20) {
                Text("\(question.text) = ?")
                    .font(.system(size: 50, weight: .bold))
                    .foregroundStyle(.red)
                TextField("Your answer", text: $userAnswer)
                    .keyboardType(.numberPad)
                    .font(.title)
                    .multilineTextAlignment(.center)
                    .padding()
                    .background(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .padding(.horizontal, 40)
                Button(action: submitAnswer) {
                    Text("Submit Answer")
                        .font(.title2.bold())
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(.green)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                }
                .padding(.horizontal, 40)
            }
            Spacer()
        }
        .padding()
    }
}
struct ResultsView: View {
    let score: Int
    let totalQuestions: Int
    var playAgain: () -> Void
    var body: some View {
        VStack(spacing: 30) {
            Spacer()
            Text("Game Over!")
                .font(.largeTitle.bold())
                .foregroundStyle(.black)
            Text("Your Score")
                .font(.title2)
                .foregroundStyle(.black)
            Text("\(score) / \(totalQuestions)")
                .font(.system(size: 70, weight: .bold))
                .foregroundStyle(.red)
            Text(score == totalQuestions ? "Perfect! Amazing!" : score >= totalQuestions / 2 ? "Great job!" : "Keep practicing!")
                .font(.title2.bold())
                .foregroundStyle(.red)
                .multilineTextAlignment(.center)
            Button(action: playAgain) {
                Text("Play Again")
                    .font(.title2.bold())
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(.red.opacity(0.9))
                    .clipShape(RoundedRectangle(cornerRadius: 20))
            }
            .padding(.horizontal, 40)
            Spacer()
        }
        .padding()
    }
}
#Preview {
    ContentView()
}

