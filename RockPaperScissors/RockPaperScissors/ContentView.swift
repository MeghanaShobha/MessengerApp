import SwiftUI

struct ContentView: View {
    @State private var computerChoice = Int.random(in: 0...2)
    @State private var shouldWin = true
    @State private var score = 0
    @State private var question = 1
    @State private var gameOver = false
    let choices = ["Rock", "Paper", "Scissors"]
    var body: some View {
        VStack(spacing: 25) {
            if gameOver {
                Text("Game Over")
                    .font(.largeTitle)
                    .bold()
                Text("Your score: \(score)")
                    .font(.title)
                Button("Play Again") {
                    restartGame()
                }
                .padding()
                .background(.blue)
                .foregroundStyle(.white)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            } else {
                Text("Rock, Paper, Scissors")
                    .font(.largeTitle)
                    .bold()
                Text("Question \(question) of 10")
                    .font(.headline)
                Text("Computer chose:")
                    .font(.headline)
                Text(choices[computerChoice])
                    .font(.title)
                    .bold()
                Text(shouldWin ? "You must WIN" : "You must LOSE")
                    .font(.title2)
                    .foregroundStyle(shouldWin ? .green : .red)
                Text("Choose your move:")
                    .font(.headline)
                HStack(spacing: 15) {
                    Button("Rock") {
                        makeMove(0)
                    }
                    .frame(width: 100, height: 50)
                    .background(.blue)
                    .foregroundStyle(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    
                    Button("Paper") {
                        makeMove(1)
                    }
                    .frame(width: 100, height: 50)
                    .background(.blue)
                    .foregroundStyle(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    Button("Scissors") {
                        makeMove(2)
                    }
                    .frame(width: 100, height: 50)
                    .background(.blue)
                    .foregroundStyle(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                }
                Text("Score: \(score)")
                    .font(.title2)
                    .bold()
            }
        }
        .padding()
    }
    func makeMove(_ playerChoice: Int) {
        let isCorrect: Bool
        if shouldWin {
            isCorrect = playerWins(
                player: playerChoice,
                computer: computerChoice
            )
        } else {
            isCorrect = playerLoses(
                player: playerChoice,
                computer: computerChoice
            )
        }
        if isCorrect {
            score += 1
        } else {
            score -= 1
        }
        if question == 10 {
            gameOver = true
        } else {
            question += 1
            computerChoice = Int.random(in: 0...2)
         shouldWin.toggle()
        }
    }
    func playerWins(player: Int, computer: Int) -> Bool {
        if player == 0 && computer == 2 {
            return true
        }
        if player == 1 && computer == 0 {
            return true
        }
        if player == 2 && computer == 1 {
            return true
        }
        return false
    }
    func playerLoses(player: Int, computer: Int) -> Bool {
        if player == 0 && computer == 1 {
            return true
        }
        if player == 1 && computer == 2 {
            return true
        }
        if player == 2 && computer == 0 {
            return true
        }
        return false
    }
    func restartGame() {
        score = 0
        question = 1
        computerChoice = Int.random(in: 0...2)
        shouldWin = true
        gameOver = false
    }
}

#Preview {
    ContentView()
}
